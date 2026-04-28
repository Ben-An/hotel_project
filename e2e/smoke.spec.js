// @ts-check
const { test, expect } = require('@playwright/test');

test.describe('Smoke Tests', () => {

  test('메인 페이지 로드', async ({ page }) => {
    await page.goto('/');
    await expect(page).toHaveTitle(/심사숙소|hotel/i);
  });

  test('메인 페이지 검색폼 존재', async ({ page }) => {
    await page.goto('/main');
    const searchForm = page.locator('form').first();
    await expect(searchForm).toBeVisible();
  });

  test('로그인 페이지 접근', async ({ page }) => {
    await page.goto('/member/login');
    await expect(page.locator('input[name="memberId"]')).toBeVisible();
    await expect(page.locator('input[name="memberPw"]')).toBeVisible();
  });

});

test.describe('Admin Pages', () => {

  test('비로그인 시 관리자 페이지 접근 제한', async ({ page }) => {
    const response = await page.goto('/admin/main');
    // 로그인 페이지로 리다이렉트되거나 접근 차단됨
    expect(response.url()).not.toContain('/admin/main');
  });

});
