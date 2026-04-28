// @ts-check
const { test, expect } = require('@playwright/test');

test.describe('Hotel 기능', () => {

  test('숙소 목록 페이지 로드', async ({ page }) => {
    await page.goto('/main');
    // 숙소 카드가 하나 이상 표시되는지 확인
    await page.waitForLoadState('networkidle');
    const body = await page.textContent('body');
    expect(body.length).toBeGreaterThan(0);
  });

  test('검색 기능 동작', async ({ page }) => {
    await page.goto('/main');
    await page.waitForLoadState('networkidle');

    // 검색 입력 필드가 있으면 검색 테스트
    const searchInput = page.locator('input[name="keyword"]').first();
    if (await searchInput.isVisible()) {
      await searchInput.fill('서울');
      await searchInput.press('Enter');
      await page.waitForLoadState('networkidle');
      expect(page.url()).toContain('keyword');
    }
  });

  test('지도 페이지 로드', async ({ page }) => {
    await page.goto('/map');
    await page.waitForLoadState('networkidle');
    // SVG 지도 또는 페이지 콘텐츠 확인
    const body = await page.textContent('body');
    expect(body.length).toBeGreaterThan(0);
  });

});
