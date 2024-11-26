<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp"%>

<!-- [ Main Content ] start -->
<div class="pc-container">
	<div class="pc-content">
		<!-- [ breadcrumb ] start -->
		<div class="page-header">
			<div class="page-block">
				<div class="row align-items-center">
					<div class="col-md-12">
						<div class="page-header-title">
							<h2 class="mb-0">상품 대쉬보드</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- [ breadcrumb ] end -->

		<!-- [ Main Content ] start -->
		<div class="row">
			<div class="col-12">
				<div class="card table-card">
					<div class="card-body p-4">
						<h4 class="text-center">제품 검색</h4>
						<br>

						<!-- 검색 조건 및 키워드 입력 부분 -->
						<div class="row g-3 align-items-center mb-3">
							<div class="col-md-3 col-lg-2">
								<select id="selectCondition" class="form-select"
									aria-label="검색 조건 선택" style="text-align: center;">
									<option value="1" selected>제품명</option>
									<option value="2">제품번호</option>
								</select>
							</div>
							<div class="col-md-9 col-lg-10">
								<input id="keyword" type="text" class="form-control"
									placeholder="검색어를 입력하세요">
							</div>
						</div>

						<!-- 카테고리 선택 부분 -->
						<div class="row g-3 align-items-center mb-3">
							<div class="col-md-2"
								style="text-align: center; display: flex; align-items: center; justify-content: center;">
								<label for="mainCategorySelect"
									class="custom-label mb-0 fw-bold">카테고리</label>
							</div>
							<div class="col-md-3">
								<select class="form-select" id="mainCategorySelect"
									onchange="mainCategoryChange()">
									<option value="">1차카테고리 선택</option>
								</select>
							</div>
							<div class="col-md-3">
								<select class="form-select" id="subCategorySelect"
									onchange="subCategoryChange()">
									<option value="">2차카테고리 선택</option>
								</select>
							</div>
							<div class="col-md-3">
								<select class="form-select" id="detailCategorySelect">
									<option value="">3차카테고리 선택</option>
								</select>
							</div>
						</div>

						<!-- 검색 및 초기화 버튼 -->
						<div class="text-center">
							<button type="button" class="btn btn-primary search-button">검색</button>
							<button type="button" class="btn btn-secondary">초기화</button>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!-- 상품 목록 테이블 -->
		<div class="col-sm-12">
			<div class="card table-card">
				<div class="card-body p-4 ">
					<h4 class="mb-2 pt-2">상품 목록</h4>
					<div class="mb-2 d-flex justify-content-between align-items-center">
						<div class="flex-grow-1">
							[총 제품수 <span id="totalItemsText">0</span>건] 선택 제품 <span
								id="selectedItemsText">0</span>건
						</div>
						<select class="form-select form-select-sm width-120px"
							id="itemsPerPageSelect">
							<option value="10">10개씩 보기</option>
							<option value="20">20개씩 보기</option>
							<option value="30">30개씩 보기</option>
							<option value="50">50개씩 보기</option>
							<option value="100">100개씩 보기</option>
							<!-- 기타 옵션들 -->
						</select>
					</div>
					<div class="mb-3">
						<button id="updateStockBtn" class="btn btn-outline-primary btn-sm"
							onclick="updateSelectedProductStock()">재고 수정</button>
						<button id="addColorBtn" class="btn btn-outline-warning btn-sm"
							onclick="handleColorAddButtonClick()">색상 추가</button>
						<button id="toggleOnlinePurchaseBtn"
							class="btn btn-outline-secondary btn-sm"
							onclick="toggleOnlinePurchase()">온라인 구매 여부 변경</button>
						<button id="deleteProductsBtn"
							class="btn btn-outline-danger btn-sm"
							onclick="deleteSelectedProducts()">제품 일괄 삭제</button>
					</div>
					<div class="table-responsive" id="dataTable">
						<table class="table table-bordered align-middle">
							<thead class="text-center">
								<tr>
									<th scope="col"><input type="checkbox"
										onclick="check_all('check', this);" class="allChk"></th>
									<th scope="col">상품 정보</th>
									<th scope="col">카테고리</th>
									<th scope="col">가격</th>
									<th scope="col">재고</th>
									<th scope="col">온라인 구매</th>
									<th scope="col" style="padding-right: 0px">수정 및 삭제</th>
								</tr>
							</thead>
							<tbody>
								<!-- 제품 데이터는 JS에서 동적으로 추가됩니다. -->
							</tbody>
						</table>
						<!-- [ Pagination ] start -->
						<nav id="pagination" aria-label="Page navigation example"></nav>
						<!-- [ Pagination ] end -->
					</div>
					<div class="no-result text-center mt-5 mb-5 visually-hidden">
						검색된 제품 내역이 없습니다.</div>
				</div>
			</div>
		</div>
		<!-- [ block3 : done ] end -->
	</div>
</div>
</div>
<!-- [ Main Content ] end -->

<script src='/static/js/product/product-list.js' defer></script>
<%@ include file="/WEB-INF/admin/common/footer.jsp"%>