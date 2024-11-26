window.addEventListener("load", async function() {
    try {
        // 첫 번째 제품 목록 불러오기 (/product/1/explore?detailCategoryId=3)
        const responseExplore = await fetch('/product/1/explore?detailCategoryId=3');
        if (!responseExplore.ok) {
            throw new Error("첫 번째 제품 데이터를 불러오는 데 실패했습니다.");
        }

        const productsExplore = await responseExplore.json();
        console.log('첫 번째 제품 데이터:', productsExplore); // 로그로 데이터 확인

        const firstProductListElement = document.getElementById("productList");
        if (!firstProductListElement) {
            console.error("첫 번째 제품 리스트를 표시할 HTML 요소가 없습니다.");
            return;
        }
        firstProductListElement.innerHTML = ""; // 기존 내용 초기화

        if (productsExplore && productsExplore.length > 0) {
            productsExplore.forEach(product => {
                const listItem = document.createElement('li');
                listItem.className = ""; // 필요한 클래스 추가 가능

                listItem.innerHTML = `
                    <a href="/views/product/detail?piId=${product.piId}">
                        <div>
                            <img src="/uploads/${product.pimgUrl}" alt="${product.piName}">
                            <span class="product-name">${product.piName}</span>
                            <span class="main_product_price">${Number(product.piPrice).toLocaleString()}원</span>
                        </div>
                    </a>
                `;
                firstProductListElement.appendChild(listItem);
            });
        } else {
            console.warn("첫 번째 제품 데이터가 비어있습니다.");
        }

        // 두 번째 추천 제품 목록 불러오기 (/product/484/recommendations?piMainCategoryId=5&piSubCategoryId=5)
        const responseRecommendations = await fetch('/product/484/recommendations?piMainCategoryId=5&piSubCategoryId=5');
        if (!responseRecommendations.ok) {
            throw new Error("두 번째 추천 제품 데이터를 불러오는 데 실패했습니다.");
        }

        const productsRecommendations = await responseRecommendations.json();
        console.log('두 번째 추천 제품 데이터:', productsRecommendations); // 로그로 데이터 확인

        // 두 번째 `ul` 요소를 찾기 위한 논리 (두 번째 block-media의 자식 ul)
        const secondProductListElements = document.querySelectorAll(".block-media ul.grid-plate.set4by1.set-mobile-2by2");
        if (!secondProductListElements || secondProductListElements.length < 2) {
            console.error("두 번째 추천 제품 리스트를 표시할 HTML 요소를 찾을 수 없습니다.");
            return;
        }

        const secondProductListElement = secondProductListElements[1];
        secondProductListElement.innerHTML = ""; // 기존 내용 초기화

        if (productsRecommendations && productsRecommendations.length > 0) {
            productsRecommendations.forEach(product => {
                const listItem = document.createElement('li');
                listItem.className = ""; // 필요한 클래스 추가 가능

                listItem.innerHTML = `
                    <a href="/views/product/detail?piId=${product.piId}">
                        <div>
                            <img src="/uploads/${product.pimgUrl}" alt="${product.piName}">
                            <span class="product-name">${product.piName}</span>
                            <span class="main_product_price">${Number(product.piPrice).toLocaleString()}원</span>
                        </div>
                    </a>
                `;
                secondProductListElement.appendChild(listItem);
            });
        } else {
            console.warn("두 번째 추천 제품 데이터가 비어있습니다.");
        }

    } catch (error) {
        console.error("제품 데이터를 불러오는 중 오류 발생:", error);
        alert("제품 목록을 불러오는 중 오류가 발생했습니다. 다시 시도해 주세요.");
    }
});
