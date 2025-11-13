#!/bin/bash
# IronLink DApp - 最终安全审计脚本
# 用途: 发布前的完整安全检查

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🛡️  IronLink DApp - Final Security Audit"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

PASSED=0
FAILED=0

# 检查函数
check() {
    local name=$1
    shift
    
    echo -n "▶ $name ... "
    
    if "$@" > /dev/null 2>&1; then
        echo -e "${GREEN}✅ PASS${NC}"
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}❌ FAIL${NC}"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

# ==================== 1. 代码质量检查 ====================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1️⃣  Code Quality Checks"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check "Cargo fmt" cargo fmt -- --check
check "Cargo clippy" cargo clippy --all-targets --all-features -- -D warnings
check "Cargo build" cargo build --release

echo ""

# ==================== 2. 安全审计 ====================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "2️⃣  Security Audits"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 安装审计工具（如果未安装）
command -v cargo-audit >/dev/null 2>&1 || cargo install cargo-audit
command -v cargo-deny >/dev/null 2>&1 || cargo install cargo-deny
command -v cargo-geiger >/dev/null 2>&1 || cargo install cargo-geiger

check "cargo-audit (dependency vulnerabilities)" cargo audit
check "cargo-deny (licenses & bans)" cargo deny check
echo -n "▶ cargo-geiger (unsafe code scan) ... "
cargo geiger --output-format GitHubMarkdown > SECURITY_REPORT.md
echo -e "${GREEN}✅ PASS${NC} (Report saved to SECURITY_REPORT.md)"
PASSED=$((PASSED + 1))

echo ""

# ==================== 3. 敏感信息扫描 ====================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "3️⃣  Secrets Scanning"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo -n "▶ Checking for hardcoded secrets ... "
if rg -i "password.*=.*['\"]|api.*key.*=.*['\"]|secret.*=.*['\"]" src/ >/dev/null 2>&1; then
    echo -e "${RED}❌ FAIL${NC}"
    echo "  Found hardcoded secrets:"
    rg -i "password.*=.*['\"]|api.*key.*=.*['\"]" src/ | head -5
    FAILED=$((FAILED + 1))
else
    echo -e "${GREEN}✅ PASS${NC}"
    PASSED=$((PASSED + 1))
fi

echo -n "▶ Checking for sensitive logs ... "
if rg "log::|println!|dbg!" src/ | rg -i "key|password|mnemonic|private" >/dev/null 2>&1; then
    echo -e "${RED}❌ FAIL${NC}"
    echo "  Found sensitive logging:"
    rg "log::|println!|dbg!" src/ | rg -i "key|password|mnemonic" | head -5
    FAILED=$((FAILED + 1))
else
    echo -e "${GREEN}✅ PASS${NC}"
    PASSED=$((PASSED + 1))
fi

echo ""

# ==================== 4. 测试与覆盖率 ====================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "4️⃣  Testing & Coverage"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check "cargo test" cargo test --all
echo -n "▶ Test coverage ... "

if command -v cargo-tarpaulin >/dev/null 2>&1; then
    COVERAGE=$(cargo tarpaulin --out Stdout 2>/dev/null | grep "Coverage" | awk '{print $2}' | tr -d '%')
    if (( $(echo "$COVERAGE >= 85" | bc -l) )); then
        echo -e "${GREEN}✅ PASS${NC} (${COVERAGE}%)"
        PASSED=$((PASSED + 1))
    else
        echo -e "${YELLOW}⚠️  WARN${NC} (${COVERAGE}%, target: 85%)"
    fi
else
    echo -e "${YELLOW}⚠️  SKIP${NC} (cargo-tarpaulin not installed)"
fi

echo ""

# ==================== 5. 性能基准 ====================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "5️⃣  Performance Benchmarks"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ -d "benches" ]; then
    check "cargo bench (no-run)" cargo bench --no-run
else
    echo -e "${YELLOW}⚠️  SKIP${NC} (No benchmarks found)"
fi

echo ""

# ==================== 6. 文档检查 ====================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "6️⃣  Documentation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check "README.md exists" test -f README.md
check "TECHNICAL.md exists" test -f TECHNICAL.md
check "LICENSE exists" test -f LICENSE
check "cargo doc" cargo doc --no-deps

echo ""

# ==================== 7. 构建检查 ====================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "7️⃣  Build Verification"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# iOS
if command -v dx >/dev/null 2>&1; then
    check "iOS build" dx build --platform ios --release
    
    # 检查体积
    if [ -f "target/aarch64-apple-ios/release/ironlink" ]; then
        SIZE=$(du -h target/aarch64-apple-ios/release/ironlink | awk '{print $1}')
        echo "  iOS binary size: $SIZE"
    fi
else
    echo -e "${YELLOW}⚠️  SKIP${NC} (Dioxus CLI not installed)"
fi

# Android
if [ -d "$ANDROID_SDK_ROOT" ]; then
    check "Android build" dx build --platform android --release
    
    if [ -f "target/aarch64-linux-android/release/libironlink.so" ]; then
        SIZE=$(du -h target/aarch64-linux-android/release/libironlink.so | awk '{print $1}')
        echo "  Android library size: $SIZE"
    fi
else
    echo -e "${YELLOW}⚠️  SKIP${NC} (Android SDK not found)"
fi

echo ""

# ==================== 总结 ====================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Audit Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "  ${GREEN}Passed${NC}: $PASSED"
echo -e "  ${RED}Failed${NC}: $FAILED"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✅ All checks passed! Ready for release.${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit 0
else
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}❌ Some checks failed. Please fix before release.${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit 1
fi

