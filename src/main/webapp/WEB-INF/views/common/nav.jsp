<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<nav id="navWrap">
    <div class="nav">
        <div class="navTop">
            <div class="navHeader">
                <div class="navbtns" id="navClose">
                    <i class="nav-close">메뉴 닫기버튼</i>
                    <h9>메뉴</h9>
                </div>
            </div>
            <div id="mainNav">
                <ul class="one-depth" style="display: block !important; visibility: visible !important;">
                    <li>
                        <a href="#" class="hasNav" data-main-category-id="">메인 카테고리 1</a>
                        <ul class="two-depth" style="display: none; visibility: hidden;">
                            <li>
                                <a href="#" class="hasNav" data-sub-category-id="">서브 카테고리 1-1</a>
                                <ul class="three-depth" style="display: none; visibility: hidden;">
                                    <li><a href="#" data-detail-category-id="">세부 카테고리 1-1-1</a></li>
                                    <li><a href="#" data-detail-category-id="">세부 카테고리 1-1-2</a></li>
                                </ul>
                            </li>
                            <li>
                                <a href="#" class="hasNav" data-sub-category-id="">서브 카테고리 1-2</a>
                                <ul class="three-depth" style="display: none; visibility: hidden;">
                                    <li><a href="#" data-detail-category-id="">세부 카테고리 1-2-1</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <!-- 추가 메인 카테고리 템플릿 -->
                    <li>메인 카테고리를 불러오는 중...</li>
                </ul>
            </div>
        </div>
        <div class="navfooterwrap">
            <div class="navFooter">
            <!-- 
                <button id="navFooterLocalshop" class="navfooterbtns">
                    <i class="nav-localshop"></i> <a href="/views/pages/nothing"><span>매장찾기</span></a>
                </button>
                 -->
	              <c:choose>
	                <c:when test="${user != null}">
	                 <button id="navFooterLogin" class="navfooterbtns">
                      <i class="nav-user"></i> <a href="/views/user/mypage">마이페이지</a>
                   </button>
	               </c:when>
	               <c:otherwise>
	                 <button id="navFooterLogin" class="navfooterbtns">
	                    <i class="nav-login"></i> <a href="/views/user/login">로그인</a>
	                 </button>
	               </c:otherwise>
	              </c:choose>
                <button id="navFooterCS" class="navfooterbtns">
                    <i class="nav-cs"></i> <a href="/views/pages/contact">고객센터</a>
                </button>
            </div>
            <!-- .navFooter -->
        </div>
    </div>
    <!-- .nav -->
    <div class="tray-overlay"></div>

</nav>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 전체 카테고리 가져오기
    axios.get('/views/categoriesPage')
        .then(response => {
            const categories = response.data;

            // 메인 카테고리별로 서브 및 디테일 카테고리를 정리
            const categoryMap = {};
            categories.forEach(category => {
                const mainId = category.mainCategoryId;
                const subId = category.subCategoryId;
                const detailId = category.detailCategoryId;

                if (!categoryMap[mainId]) {
                    categoryMap[mainId] = {
                        name: category.mainCategoryName,
                        subCategories: {}
                    };
                }

                if (subId) {
                    if (!categoryMap[mainId].subCategories[subId]) {
                        categoryMap[mainId].subCategories[subId] = {
                            name: category.subCategoryName,
                            detailCategories: []
                        };
                    }

                    if (detailId) {
                        categoryMap[mainId].subCategories[subId].detailCategories.push({
                            id: detailId,
                            name: category.detailCategoryName
                        });
                    }
                }
            });


            // HTML에 데이터를 채우기
            const mainNavUl = document.querySelector('#mainNav > ul.one-depth');
            mainNavUl.innerHTML = '';
            for (const mainId in categoryMap) {
                const mainCategory = categoryMap[mainId];
                let mainLi = document.createElement('li');
                let mainAnchor = document.createElement('a');
                mainAnchor.href = '#';
                mainAnchor.className = 'hasNav';
                mainAnchor.dataset.mainCategoryId = mainId;
                mainAnchor.textContent = mainCategory.name;
                mainLi.appendChild(mainAnchor);

                let subUl = document.createElement('ul');
                subUl.className = 'two-depth';
                subUl.style.display = 'none';

                for (const subId in mainCategory.subCategories) {
                    const subCategory = mainCategory.subCategories[subId];
                    let subLi = document.createElement('li');
                    let subAnchor = document.createElement('a');
                    subAnchor.href = '#';
                    subAnchor.className = 'hasNav';
                    subAnchor.dataset.subCategoryId = subId;
                    subAnchor.textContent = subCategory.name;
                    subLi.appendChild(subAnchor);

                    let detailUl = document.createElement('ul');
                    detailUl.className = 'three-depth';
                    detailUl.style.display = 'none';

                    subCategory.detailCategories.forEach(detailCategory => {
                        let detailLi = document.createElement('li');
                        let detailAnchor = document.createElement('a');

                        // list.jsp로 전달되는 URL에 main, sub, detail 카테고리 ID를 추가
                        detailAnchor.href = '/views/product/list?mainCategoryId=' + mainId + '&subCategoryId=' + subId + '&detailCategoryId=' + detailCategory.id;
                        detailAnchor.dataset.detailCategoryId = detailCategory.id;
                        detailAnchor.textContent = detailCategory.name;

                        detailLi.appendChild(detailAnchor);
                        detailUl.appendChild(detailLi);
                    });

                    subLi.appendChild(detailUl);
                    subUl.appendChild(subLi);
                }

                mainLi.appendChild(subUl);
                mainNavUl.appendChild(mainLi);
            }

            // LNB UI 설정 적용
            lnbUI.click('#mainNav li', 200); // 카테고리 메뉴 클릭 시 부드러운 토글 애니메이션 적용
        })
        .catch(error => {
            console.error('전체 카테고리를 불러오는데 실패했습니다:', error);
            console.error('에러 응답:', error.response); // 에러 상세 정보 확인
            document.querySelector('#mainNav > ul.one-depth').innerHTML = '<li>전체 카테고리를 불러오는데 실패했습니다.</li>';
        });
});
</script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
