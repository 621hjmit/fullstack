<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>

<!-- [Page specific CSS] start -->
	<link rel="stylesheet" href="https://snippet.dhtmlx.com/codebase/assets/css/auxiliary_controls.css">
<!-- [Page specific CSS] end -->

<!-- [ Main Content ] start -->
	<div class="pc-container">		
		<div class="pc-content">
<!-- [ page title ] start -->
			<div class="page-header">
				<div class="page-block">
					<div class="row align-items-center">
						<div class="col-md-12">
							<div class="page-header-title">
								<h2 class="mb-0"><b>환불 주문 관리</b></h2>
							</div>
						</div>
					</div>
				</div>
			</div>
<!-- [ page title ] end -->
			
<!-- [ block1 : search conditions ] start -->			
			<%@ include file="/WEB-INF/admin/order/order-refund-searchconditions.jsp" %>
<!-- [ block1 : search conditions ] end -->

<!-- [ block2 : Buttons ] start -->
			<%@ include file="/WEB-INF/admin/order/order-common-block2-buttons.jsp" %>
<!-- [ block2 : Buttons ] end -->

<!-- [ block3 : table header ] start -->
<!-- [ block3-1 : title ] start -->
			<h4 class="mb-2 pt-2 "><b>환불 주문 목록</b></h4>
<!-- [ block3-1 : title ] end -->
<!-- [ block3-2 : summary ] start -->
<!-- 총 주문 건수 (전체?)와 그 중 검색된 결과 주문 건수 생성되도록 -->
				<div class="mb-2 d-flex justify-content-between align-items-center">
					<div class="flex-grow-1">
					[주문건수 총 <span id="searchResults">0</span>건]
					</div>
<!-- [ block3-2 : summary ] end -->		
<!-- [ block3-3 : sorting ] start -->
					<select onchange="setPageCount(this)" class="form-select form-select-sm width-120px">
						<option value="10">10개씩 보기</option>
					<option value="20">20개씩 보기</option>
					<option value="50">50개씩 보기</option>
					<option value="100">100개씩 보기</option>
					</select>
				</div>
<!-- [ block3-3 : sorting ] end -->

<!-- [ block3 : table header ] end -->
				
<!-- [ block4 : Order Delivery List ] start -->
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
									<div id="orderGrid" style="width: 100%; height: 60vh;"></div>
								</div>
							</div>
						</div>
						<div class="no-result text-center mt-5 mb-5 visually-hidden">
						        검색된 주문 내역이 없습니다.
						</div>
<!-- [ block4 : Order Delivery List ] end -->

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
	<script src="/static/js/admin/order/order-refund.js"></script>
<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>