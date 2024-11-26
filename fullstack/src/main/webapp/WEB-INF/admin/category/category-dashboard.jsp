<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp"%>

<!-- [ Main Content ] start -->
<div class="pc-container">
	<div class="pc-content">

		<!-- [ page title ] start -->
		<div class="page-header">
			<div class="page-block">
				<div class="row align-items-center">
					<div class="col-md-12">
						<div class="page-header-title">
							<h2 class="mb-0">카테고리 관리</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- [ page title ] end -->

		<!-- [ Category Management Card ] start -->
		<div class="card table-card p-4 mb-4">
			<div class="card-body">
				<div class="row">

					<!-- 왼쪽: 카테고리 관리 -->
					<div class="col-md-5">
						<h4 class="mb-4">카테고리 수정 및 삭제</h4>

						<!-- 1차 카테고리 선택 -->
						<div class="row mb-4">
							<div class="col-sm-8">
								<label for="mainCategorySelect" class="form-label">1차
									카테고리 선택</label> <select class="form-select" id="mainCategorySelect">
									<option value="">1차 카테고리 선택</option>
									<!-- 1차 카테고리 옵션들 -->
								</select>
							</div>
							<div class="col-sm-4" id="mainCategoryActions"></div>
							<!-- 수정/삭제 버튼이 여기에 추가될 예정 -->
						</div>

						<!-- 2차 카테고리 선택 -->
						<div class="row mb-4">
							<div class="col-sm-8">
								<label for="subCategorySelect" class="form-label">2차
									카테고리 선택</label> <select class="form-select" id="subCategorySelect">
									<option value="">2차 카테고리 선택</option>
									<!-- 2차 카테고리 옵션들 -->
								</select>
							</div>
							<div class="col-sm-4" id="subCategoryActions"></div>
							<!-- 수정/삭제 버튼이 여기에 추가될 예정 -->
						</div>

						<!-- 3차 카테고리 선택 -->
						<div class="row mb-4">
							<div class="col-sm-8">
								<label for="detailCategorySelect" class="form-label">3차
									카테고리 선택</label> <select class="form-select" id="detailCategorySelect">
									<option value="">3차 카테고리 선택</option>
									<!-- 3차 카테고리 옵션들 -->
								</select>
							</div>
							<div class="col-sm-4" id="detailCategoryActions"></div>
							<!-- 수정/삭제 버튼이 여기에 추가될 예정 -->
						</div>
					</div>

					<!-- 구분선 -->
					<div
						class="col-md-1 d-flex justify-content-center align-items-center">
						<div style="height: 100%; border-right: 1px solid #6c757d;"></div>
						<!-- #6c757d는 'secondary' 색상에 해당 -->
					</div>

					<!-- 오른쪽: 카테고리 추가 -->
					<!-- 카테고리 추가 UI -->
					<div class="col-md-6">
						<h4 class="mb-4">카테고리 추가</h4>
						<div class="row mb-4">
							<div class="col-sm-8">
								<label for="addCategorySelect" class="form-label">추가할
									카테고리 선택</label> <select class="form-select" id="addCategorySelect">
									<option value="">카테고리 선택</option>
									<option value="1">1차 카테고리</option>
									<option value="2">2차 카테고리</option>
									<option value="3">3차 카테고리</option>
								</select>

								<!-- 여기서 동적으로 추가할 컨테이너 -->
								<div id="dynamicInputsContainer" class="mt-3"></div>

								<button class="btn btn-success mt-4" id="addCategoryBtn"
									style="display: none;">카테고리 추가</button>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- [ Category Management Card ] end -->

		<!-- [ block1 : real time sales ] start -->
		<div class="col-sm-12">
			<div class="card table-card">
				<div class="card-body p-4 ">
					<div class="d-flex flex-row align-items-end">
						<h4 class="mb-0 p-2 ">카테고리 목록 보기</h4>
					</div>

					<div class="row">
						<table class="table col-md-12">
							<thead>
								<tr>
									<th scope="col" class="text-center col-4">1차 카테고리</th>
									<th scope="col" class="text-center col-3">2차 카테고리</th>
									<th scope="col" class="text-center col-3">3차 카테고리</th>
								</tr>
							</thead>

							<tbody class="table-group-divider" id="categoryTableBody">
								<!-- JavaScript에서 동적으로 추가됩니다 -->
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- [ block1 : real time sales ] end -->

	</div>
</div>
<!-- [ Main Content ] end -->



<!-- [Page Specific JS] start -->

<script src='/static/js/category/category-dashboard.js' defer></script>
<%@ include file="/WEB-INF/admin/common/footer.jsp"%>