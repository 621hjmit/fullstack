<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel='stylesheet' href='/static/css/style.css' />
<link rel='stylesheet' href='/static/css/list.css' />
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src='/static/js/script.js' defer></script>
<script src='/static/js/product/list.js' defer></script>



<main id="main" class="margin-top-35">
    <ul class="breadcrumb main-padding">
        <li class="breadcrumb-item">여성</li>
        <li class="breadcrumb-item hidden" aria-hidden="true">여성복</li>
        <li class="breadcrumb-item active">봄-여름 2024 컬렉션 룩</li>
    </ul>
    <div class="products-filter-container">
        <div class="products-filter">
            <form class="js-product-filter-form" method="get" id="product-filter">
                <button class="filterNavButton">필터
                    <span class="dropdown-btn-toggler"></span>
                </button>

                <div class="flex-left" id="filterBox">
                    <div class="show-in-mobile">
                        <div class="navHeader">
                            <div class="navbtns" id="filterClose">
                                <i class="nav-close">필터 닫기버튼</i>
                                <h9>필터</h9>
                            </div>
                        </div>
                    </div>

 <!--                    필터 기준 온라인스토어 구매 가능
                    <fieldset class="switch-container">
                        <legend class="products-filter-group-legend">필터 기준 온라인스토어 구매가능</legend>
                        <input role="switch" type="checkbox" class="switch-input-default" id="online-switch" value="online">
                        <span class="switch-input"></span>
                        <label for="online-switch" id="online-text">온라인스토어 구매 가능</label>
                    </fieldset> -->

                    <!-- 필터 기준 컬러 -->
                    <fieldset class="dropdown-container dropdown-colorWithNames" style="">
                        <legend class="products-filter-group-legend">필터 기준 컬러</legend>
                        <button class="dropdown-btn js-dropdownbtn" aria-expanded="false"
                                aria-controls="dropdown-colorWithNames">
                            컬러
                            <span class="dropdown-btn-toggler"></span>
                        </button>
                        <div class="dropdown js-dropdown dropdown-checkbox" id="dropdown-colorWithNames" aria-hidden="true">
                            <ul class="dropdown-list" id="color-filter">
                                <!-- JavaScript에서 동적으로 색상 옵션 추가 -->
                            </ul>
                        </div>
                    </fieldset>

                    <!-- 필터 기준 소재 -->
                    <fieldset class="dropdown-container" style="">
                        <legend class="products-filter-group-legend">소재</legend>
                        <button class="dropdown-btn js-dropdownbtn" aria-expanded="false"
                                aria-controls="dropdown-materials">소재<span class="dropdown-btn-toggler"></span></button>
                        <div class="dropdown js-dropdown dropdown-checkbox white-box" id="dropdown-materials" aria-hidden="true">
                            <ul class="dropdown-list" id="material-filter">
                                <!-- JavaScript에서 동적으로 소재 옵션 추가 -->
                            </ul>
                        </div>
                    </fieldset>

                    <!-- 필터 기준 사이즈 -->
                    <fieldset class="dropdown-container" style="">
                        <legend class="products-filter-group-legend">필터 기준 사이즈</legend>
                        <button class="dropdown-btn js-dropdownbtn" aria-expanded="false"
                                aria-controls="dropdown-size">사이즈<span class="dropdown-btn-toggler"></span></button>
                        <div class="dropdown js-dropdown dropdown-btns" id="dropdown-size" aria-hidden="true">
                            <ul class="dropdown-list" id="size-filter">
                                <!-- JavaScript에서 동적으로 사이즈 옵션 추가 -->
                            </ul>
                        </div>
                    </fieldset>
                </div>

                <div class="show-in-mobile" id="columSettingBox">
                    <input class="hidden" type="radio" id="two" name="column" value="two" checked>
                    <label for="two" class="hidden">two line</label>
                    <input class="hidden" type="radio" id="one" name="column" value="one" >
                    <label for="one" class="hidden">one line</label>
                    <button class="columnSetting" id="twoVisibleBtn"><div class="columnSettingInner"></div></button>
                    <button class="columnSetting" id="oneVisibleBtn"><div class="columnSettingInner"></div></button>
                </div>

                <div class="flex-right right-sort-box" id="sortBtn">
                    <span class="form-item-select-label-wrapper">
                        <label class="form-sort-label" for="result-sort-by">정렬 기준</label>
                        <select id="result-sort-by" name="sortby" aria-describedby="refresh-grid-notify">
                            <option value="relevance" selected="true">관련성</option>
                            <option value="low-price">낮은 가격순</option>
                            <option value="high-price">높은 가격순</option>
                        </select>
                        <span class="current-sort" aria-hidden="true">관련성</span>
                        <span class="dropdown-btn-toggler"></span>
                    </span>
                </div>
            </form>
        </div>
    </div>
</main>

    <div class="prd-list twoLine">
        <c:forEach var="product" items="${products}">
            <a href="/views/product/detail?piId=<c:out value="${product.piId}" />" class="prd-item">
                <div class="prd-image"><img src="<c:out value="${product.imageUrl}" />"></div>
                <div class="prd-meta">
                    <p class="prd-name"><c:out value="${product.piName}" /></p>
                    <p class="prd-price"><span class="sr-only">, </span>₩ <c:out value="${product.piPrice}" /></p>
                </div>
            </a>
        </c:forEach>
    </div>
    <div class="moreBtn">더 많은 상품 보기</div>
</main>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>