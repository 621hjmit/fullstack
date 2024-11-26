<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!-- [ Main Content ] start -->
<div class="pc-container">
	<div class="pc-content">
		<!-- [ breadcrumb ] start -->
		<div class="page-header">
			<div class="page-block">
				<div class="row align-items-center">
					<div class="col-md-12">
						<div class="page-header-title">
							<h2 class="mb-0">제품 수정</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- [ breadcrumb ] end -->
		<!-- [ Main Content ] start -->
		<div class="row">
			<!-- [ sample-page ] start -->
			<div class="col-sm-12">
				<div class="card table-card">
					<div class="card-body" style="padding: 0px;">
						<table class="table">
							<tr>
								<th class="text-center col-sm-2"
									style="border-right: 1px solid #ccc;">카테고리 선택</th>
								<td>
									<div class="d-flex">
										<div class="col-sm-4">
											<select class="form-select"
												aria-label="Default select example" id="mainCategorySelect"
												onchange="mainCategoryChange()">
												<option value="">1차카테고리 선택</option>
											</select>
										</div>
										<div class="col-sm-4 ms-2">
											<select class="form-select"
												aria-label="Default select example" id="subCategorySelect"
												onchange="subCategoryChange()">
												<option value="">2차카테고리 선택</option>
											</select>
										</div>
										<div class="col-sm-4 ms-2">
											<select class="form-select"
												aria-label="Default select example"
												id="detailCategorySelect">
												<option value="">3차카테고리 선택</option>
											</select>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td class="text-center" colspan="2">
									<div class="col-sm-50">
										<button type="button" class="btn btn-primary"
											onclick="updateSelectedCategory()">카테고리 선택</button>
									</div>
								</td>
							</tr>
							<tr>
								<th class="text-center col-sm-2"
									style="border-right: 1px solid #ccc;">선택된 카테고리</th>
								<td><input type="text" id="selectedCategory"
									class="form-control" style="font-weight: bold;" readonly></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<div class="card table-card">
					<div class="card-body" style="padding: 0px;">
						<table class="table">
							<!-- 메인 이미지 불러오기 -->
							<tr>
								<th class="text-center col-sm-2"
									style="border-right: 1px solid #ccc;">메인 이미지 등록</th>
								<td>
									<div id="mainImagePreviewContainer" class="mt-3"></div> <input
									type="file" id="mainImageUpload" accept="image/*"
									onchange="previewMainImage()">
								</td>
							</tr>

							<!-- 서브 이미지 등록 -->
							<tr>
								<th class="text-center col-sm-2"
									style="border-right: 1px solid #ccc;">세부 이미지 등록</th>
								<td>
									<div id="detailImagePreviewContainer" class="mt-3"></div> <input
									type="file" id="detailImageUpload" multiple accept="image/*"
									onchange="previewDetailImages()">
								</td>
							</tr>

							<!-- 기존 상품 코드 입력 -->
							<tr>
								<th class="text-center col-sm-2"
									style="border-right: 1px solid #ccc;">상품 코드</th>
								<td><input type="text" class="form-control" id="piCode"></td>
							</tr>
							<tr>
								<th class="text-center" style="border-right: 1px solid #ccc;">상품명</th>
								<td><input type="text" class="form-control" id="piName"></td>
							</tr>
							<tr>
								<th class="text-center" style="border-right: 1px solid #ccc;">가격</th>
								<td><input type="number" min="0" class="form-control"
									id="piPrice"></td>
							</tr>
							<tr>
								<th class="text-center col-sm-2 ms-2"
									style="border-right: 1px solid #ccc;">색상 명칭</th>
								<td><input type="text" class="form-control"
									id="piColorTitle"></td>
							</tr>
							<tr>
								<th class="text-center col-sm-2 ms-2"
									style="border-right: 1px solid #ccc;">소재</th>
								<td><input type="text" class="form-control"
									id="piMaterialTitle"></td>
							</tr>
							<tr>
								<th class="text-center" style="border-right: 1px solid #ccc;">사이즈</th>
								<td>
									<div id="sizeInputContainer">
										<input type="text" class="form-control mb-2" readonly>
									</div>
									<button type="button" class="btn btn-dark"
										onclick="openSizeSelection()">선택</button>
								</td>
							</tr>
							<tr>
								<th class="text-center" style="border-right: 1px solid #ccc;">상품
									주요 정보</th>
								<td>
									<div id="inputContainer">
										<input type="text" class="form-control mb-2">
									</div>
									<button type="button" class="btn btn-primary me-2"
										onclick="addInputField()">추가</button>
									<button type="button" class="btn btn-danger"
										onclick="removeLastInputField()">삭제</button>
								</td>
							</tr>
							<tr>
								<th class="text-center" style="border-right: 1px solid #ccc;">제품
									세부 정보</th>
								<td>
									<div class="d-flex align-items-center">
										<input type="number" min="0" class="form-control me-2"
											placeholder="제품 착용 모델의 키를 입력하세요." id="pdiHeight"> <input
											type="text" class="form-control me-2"
											placeholder="제품 착용 모델의 사이즈를 입력하세요." id="pdiSize">
									</div>
								</td>
							</tr>
							<tr>
								<th class="text-center" style="border-right: 1px solid #ccc;">제조국</th>
								<td><input type="text" class="form-control"
									id="piCountryOfOrigin"></td>
							</tr>
							<tr>
								<th class="text-center" style="border-right: 1px solid #ccc;">스토리
									비하인드</th>
								<td>
									<div class="d-flex align-items-center">
										<textarea class="form-control me-2" rows="3" id="piStory"></textarea>
									</div>
								</td>
							</tr>
							<tr>
								<th class="text-center" style="border-right: 1px solid #ccc;">색상
									카테고리</th>
								<td>
									<div id="colorInputContainer">
										<input type="text" class="form-control mb-2" readonly>
									</div>
									<button type="button" class="btn btn-dark"
										onclick="openColorSelection()">선택</button>
								</td>
							</tr>
							<tr>
								<th class="text-center" style="border-right: 1px solid #ccc;">소재
									카테고리</th>
								<td>
									<div class="d-flex align-items-center">
										<input type="text" id="selectedMaterial" data-material-id=""
											class="form-control me-2" readonly
											placeholder="선택버튼을 클릭하여 소재를 선택해주세요" id="pmName">
										<button type="button" class="btn btn-dark"
											onclick="openMaterialSelection()">선택</button>
									</div>
								</td>
							</tr>
							<tr>
								<th colspan="2" class="text-center"
									style="border-right: 1px solid #ccc;">
									<button id="updateButton" class="btn btn-primary" onclick="updateProduct()">제품 수정</button>
								</th>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- [ sample-page ] end -->
	</div>
	<!-- [ Main Content ] end -->
</div>
<!-- [ Main Content ] end -->

<script src='/static/js/product/product-update.js' defer></script>

<%@ include file="/WEB-INF/admin/common/footer.jsp"%>
