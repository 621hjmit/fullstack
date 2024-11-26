<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>

<!-- [Page specific CSS] start -->
	<link rel="stylesheet" href="https://snippet.dhtmlx.com/codebase/assets/css/auxiliary_controls.css">
<!-- [Page specific CSS] end -->

<!-- [ Main Content ] start ---------------------------------------------------------------------------------->
	<div class="pc-container">		
		<div class="pc-content">
<!-- [ page title ] start -->
			<div class="page-header">
				<div class="page-block">
					<div class="row align-items-center">
						<div class="col-md-12">
							<div class="page-header-title">
								<h2 class="mb-0"><b>주문 조회 | 관리</b></h2><br>
							</div>
						</div>
					</div>
				</div>
			</div>
<!-- [ page title ] end -->
			
<!-- [ block1 : search conditions ] start -->			
			<%@ include file="/WEB-INF/admin/order/order-management-searchconditions.jsp" %>
<!-- [ block1 : search conditions ] end -->

<!-- [ block2 : Buttons ] start -->
			<%@ include file="/WEB-INF/admin/order/order-common-block2-buttons.jsp" %>
<!-- [ block2 : Buttons ] end -->

<!-- [ block3 : table header ] start -->
<!-- [ block3-1 : title ] start -->
			<h5 class="mb-2 pt-2 "><b>주문 관리</b>
				<button type="button" class="btn btn-icon btn-link-primary avtar-xs" data-bs-toggle="popover" 
				    data-bs-title="주문 목록"  data-bs-placement="bottom" data-bs-html="true"
				    data-bs-content="
					<ul>
						<li>검색조건을 넣지 않으면 오늘의 주문이 조회됩니다.</li>
						<li>주문을 드래그하면 순서를 원하는대로 변경할 수 있습니다. </li>
						<li>주문을 삭제하면 주문 전체가 삭제상태로 변경되어 조회되지 않습니다. </li>
					</ul>">
					<i class="ti ti-info-circle"></i>
				</button>
			</h5>
<!-- [ block3-1 : OrderManagemet Button ] end -->
			<div class="mb-3">
				<button type="button" class="btn btn-outline-danger btn-sm" onclick="prepareProduct()">상품준비중처리</button>
				<button type="button" class="btn btn-outline-danger btn-sm" onclick="closeOrder()">주문완료처리</button>
				<button type="button" class="btn btn-outline-danger btn-sm" onclick="deleteOrder()">주문삭제</button>
			</div>
<!-- [ block3-2 : summary ] start -->
			<div class="mb-2 d-flex justify-content-between align-items-center">
				<div class="flex-grow-1">
				[조회된 주문 건 수 총 <span id="searchResults">0</span>건]
				</div>
				<select onchange="setPageCount(this)" class="form-select form-select-sm width-120px">
					<option value="10">10개씩 보기</option>
					<option value="20">20개씩 보기</option>
					<option value="50">50개씩 보기</option>
					<option value="100">100개씩 보기</option>
				</select>
			</div>
<!-- [ block3-2 : summary ] end -->		
<!-- [ block3 : table header ] end -->

<!-- [ block4 : Order List ] start -->				
			<div class="col-lg-12">
				<div class="card table-card">
					<div class="card-body p-4 ">
						<ul class="nav nav-tabs mb-3" id="myTab" role="tablist">
							<li class="nav-item">
								<a onclick="showOrders()" class="nav-link active text-uppercase" id="order-tab" data-bs-toggle="tab" href="#orderList"
							    role="tab" aria-controls="order" aria-selected="true">주문목록</a>
							</li>
							<li class="nav-item">
								<a onclick="showOrderItems()" class="nav-link text-uppercase" id="orderItem-tab" data-bs-toggle="tab" href="#orderList"
							    role="tab" aria-controls="order" aria-selected="false">아이템 주문목록</a>
							</li>
						</ul>
						<div class="tab-content" id="myTabContent">
							<div class="tab-pane fade show active" role="tabpanel" aria-labelledby="order-tab">
								<div class="table-responsive">
									<div id="orderGrid" style="width: 100%; height: 55vh;"></div>
								</div>
							</div>
						</div>
						<div class="no-result text-center mt-5 mb-5 visually-hidden">
						        검색된 주문 내역이 없습니다.
						</div>
<!-- [ block4 : Order List ] End -->

<!-- [ block5 : Pagination ] start -->				
						<div id = "pagination"></div>
<!-- [ block5 : Pagination ] END -->

					</div>
				</div>
			</div>
		</div>
	</div>
<!-- [ Main Content ] end ---------------------------------------------------------------------------------->
<!-- [Page Specific JS] start ------------------------------------------------------------------------------>
	<script src="/static/assets/js/plugins/simple-datatables.js"></script>
	<!-- DatePicker 먼저 로드하고 그다음에 유저를 로드해야합니다. -->
	<script src="/static/assets/js/plugins/bootstrap-datepicker.min.js"></script>
	<script src="/static/js/admin/order/order-management.js"></script>
<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>