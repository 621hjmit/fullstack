<%@page import="com.shop.fullstack.user.vo.UserInfoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!-- 로컬 CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<link rel='stylesheet' href='/static/css/detail.css' />
<!-- 로컬 js -->
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src='/static/js/script.js' defer></script>
<script src='/static/js/product/detail.js' defer></script>
<!-- 헤더 끝 -->
<main id="main" class="margin-bottom-60">
	<div class="detail-container">
		<div class="back-button-area">
			<button class="back-button" role="link" onclick="history.back();">
				<div class="back-button-left">
					<svg xmlns="http://www.w3.org/2000/svg" width="27" height="16"
						focusable="false" aria-hidden="true">
                     <g fill="none" fill-rule="evenodd" stroke="#333"
							stroke-linecap="round" stroke-width="2">
                        <path _ngcontent-hermes-c203198840=""
							d="M10 1L2 8l8 7M4 8h21.1874547"></path>
                     </g>
                  </svg>
				</div>
				<div class="back-button-right">
					<a href="javascript:window.location=document.referrer;"
						class="back-text hide-in-mobile sr-only">돌아가기</a>
				</div>
			</button>
		</div>
		<div class="prd-section">
			<div class="right-column">
				<div class="prd-image-mobile swiperWrap">
					<div class="swiper mySwiper">
						<div class="swiper-wrapper" id="swiperWrapper">
							<!-- 동적으로 이미지가 추가될 부분입니다. -->
						</div>
						<div class="swiper-pagination"></div>
					</div>
				</div>
				<div class="prd-info">
					<div class="prd-info-items" id="prdNamePrice">
						<h2>
							<span id="piName">상품 이름</span>
						</h2>
						<p>
							&#x20A9; <span id="piPrice">0</span>
						</p>
					</div>
					<div class="prd-info-items" id="prdColor">
						<div class="prd-info-items-header">
							<h4>컬러</h4>
							<span id="selectedColor"></span>
						</div>
						<div class="prd-info-items-body flex border-top"
							id="colorContainer">
							<!-- 동적으로 컬러 버튼이 추가~~-->
						</div>
					</div>
					<div class="prd-info-items dropdown2" id="prdSize">
						<div class="prd-info-items-header dropdown-btn js-dropdownbtn">
							<h4>사이즈</h4>
							<span class="dropdown-btn-toggler"></span>
						</div>
						<div class="prd-info-items-body dropdown js-dropdown"
							id="sizeContainer">
							<!-- 동적으로 사이즈 버튼이 추가~~-->
						</div>
						<input type="hidden" id="selectedSize" name="selectedSize"
							value="" />
					</div>
					<div class="prd-info-items" id="prdCart">
						<div class="prd-info-items-body">
							<button onclick="insertIntoCart()"
								class="cart-btn btn-200 btn-sm button-base button-primary">장바구니에
								담기</button>
						</div>
					</div>
					<div class="prd-info-items" id="prdExplaination">
						<div class="prd-info-items-body">
							<p id="productMaterial">제품 소재 설명이 여기에 표시됩니다.</p>

							<!-- 제품 메인 정보 시작 -->
							<p id="mainInfoContainer">제품 메인 정보가 여기에 표시됩니다.</p>
							<br>

							<!-- 제품 제조국 -->
							<p id="productCountryOfOrigin">제품 제조국 정보가 여기에 표시됩니다.</p>
						</div>
					</div>
				</div>
				<!-- .prd-info -->
				<div class="prd-info prd-other-info accordian">
					<!-- 제품 세부 정보 시작 -->
					<div class="prd-info-items dropdown2" id="prd-detail">
						<div class="prd-info-items-header dropdown-btn js-dropdownbtn">
							<h4>제품 세부 정보</h4>
							<span class="dropdown-btn-toggler"></span>
						</div>
						<div class="prd-info-items-body dropdown js-dropdown">
							<p id="productDetailInfo"></p>
						</div>
					</div>
					<!-- 제품 세부 정보 끝 -->
					<!-- 제품 추가 정보 시작 -->
					<div class="prd-info-items dropdown2" id="prd-add">
						<div class="prd-info-items-header dropdown-btn js-dropdownbtn">
							<h4>추가 정보</h4>
							<span class="dropdown-btn-toggler"></span>
						</div>
						<div class="prd-info-items-body dropdown js-dropdown">
							<ul id="productAddInfoList">
								<!-- 추가 정보가 동적으로 삽입~~~~ -->
							</ul>
						</div>
					</div>
					<!-- 제품 추가 정보 끝 -->
					<!-- 제품 관리 시작 -->
					<div class="prd-info-items dropdown2" id="prd-care">
						<div class="prd-info-items-header dropdown-btn js-dropdownbtn">
							<h4>관리</h4>
							<span class="dropdown-btn-toggler"></span>
						</div>
						<div class="prd-info-items-body dropdown js-dropdown"
							id="productCareDesc">
							<!-- 관리정보 동적으로 삽입~~~ -->
						</div>
					</div>
					<!-- 제품 관리 끝 -->
					<!-- 배송 및 반품 시작 -->
					<div class="prd-info-items dropdown2" id="prd-delivery">
						<div class="prd-info-items-header dropdown-btn js-dropdownbtn">
							<h4>배송 및 반품</h4>
							<span class="dropdown-btn-toggler"></span>
						</div>
						<div class="prd-info-items-body dropdown js-dropdown">
							<h5>배송</h5>
							<ul id="shippingInfoList">
								<!-- 배송 정보가 여기에 동적으로 추가됩니다 -->
							</ul>

							<h5>결제수단</h5>
							<ul id="paymentMethodsList">
								<!-- 결제수단 정보가 여기에 동적으로 추가됩니다 -->
							</ul>

							<h5>교환/환불</h5>
							<ul id="exchangeReturnsInfoList">
								<!-- 교환/환불 정보가 여기에 동적으로 추가됩니다 -->
							</ul>
						</div>
					</div>
					<!-- 배송 및 반품 끝 -->
					<!-- 선물하기 시작 -->
					<div class="prd-info-items dropdown2" id="prd-gift">
						<div class="prd-info-items-header dropdown-btn js-dropdownbtn">
							<h4>선물 하기</h4>
							<span class="dropdown-btn-toggler"></span>
						</div>
						<div class="prd-info-items-body dropdown js-dropdown">
							<ul>
								<!-- 선물하기 동적 추강~~ -->
							</ul>
						</div>
					</div>
					<!-- 선물하기 끝 -->
					<!-- 기타 정보 -->
					<div class="prd-info-items" id="prd-etc">
						<div class="prd-info-items-body">
							<p>
								제품 번호: <span id="piCode">H4E0501DV9036</span><br> <br>
								더 자세히 알고 싶으신가요? <a href="contact.html"
									class="text-decoration-underline">고객 서비스에 문의하기</a>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="left-column">
				<div class="prd-image-section">
					<div class="thumb-list" id="thumbList">
						<!-- 동적으로 썸네일 이미지가 추가될 부분입니다. -->
					</div>
					<div class="prd-image">
						<img id="mainImage" src="" alt="상품 이미지">
					</div>
				</div>
				<!-- .prd-image-section -->
				<div class="prd-story">
					<h3>스토리 비하인드</h3>
					<p id="productStory">제품 스토리가 여기에 표시됩니다.</p>
				</div>
				<!-- 기존 내용 그대로 유지 -->
				<div class="related-prd">
					<h3>완벽한 파트너</h3>
					<ul id="perfectPartnerContainer">
						<!-- 완벽한 파트너 추천 제품이 동적으로 추가됩니다 -->
					</ul>
				</div>

				<div class="related-prd">
					<h3>계속 탐색하기</h3>
					<ul id="continueExploringContainer">
						<!-- 계속 탐색하기 추천 제품이 동적으로 추가됩니다 -->
					</ul>
				</div>
			</div>
		</div>
		<div class="zoom">
			<div class="zoom-thumb-list" id="zoomThumbList">
				<!-- 썸네일 이미지는 여기에서 동적으로 추가 -->
			</div>
			<div class="zoom-big-img">
				<img id="zoomBigImage" src="" alt="확대 이미지">
			</div>
			<div class="zoom-range">
				<div class="zoom-close-wrap">
					<button class="zoom-close">
						<span class="sr-only">닫기</span>
					</button>
				</div>
				<div class="zoom-plus-minus-wrap">
					<button class="plus">
						<span class="sr-only">확대</span>
						<svg _ngcontent-hermes-c1604145409=""
							xmlns="http://www.w3.org/2000/svg" viewBox="0 0 43 43" width="43"
							height="43" focusable="false">
							<g _ngcontent-hermes-c1604145409="" fill="none"
								fill-rule="evenodd" stroke="#333" stroke-width="2"
								transform="translate(1 1)">
							<circle _ngcontent-hermes-c1604145409="" cx="20.5" cy="20.5"
								r="20.5" fill="transparent"></circle>
							<path _ngcontent-hermes-c1604145409="" stroke-linecap="round"
								d="M14 20.5h13M20.5 14v13"></path></g></svg>
					</button>
					<div class="zoom-scroll">
						<div class="zoom-scroll-thumb"></div>
					</div>
					<button class="minus">
						<span class="sr-only">축소</span>
						<svg _ngcontent-hermes-c1604145409=""
							xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 40" width="43"
							height="43" focusable="false">
							<g _ngcontent-hermes-c1604145409="" fill="none"
								fill-rule="evenodd" stroke="#333" stroke-width="2">
							<circle _ngcontent-hermes-c1604145409="" cx="20" cy="20" r="19"
								fill="transparent"></circle>
							<path _ngcontent-hermes-c1604145409="" stroke-linecap="round"
								d="M14 20.5h13"></path></g></svg>
					</button>
				</div>
			</div>
		</div>
	</div>
</main>

<script>
    let uiNum = '<c:out value="${user.uiNum}"/>';
</script>

</main>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>