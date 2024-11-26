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
								<h2 class="mb-0"><b>결제 관리</b></h2>
							</div>
						</div>
					</div>
				</div>
			</div>
<!-- [ page title ] end -->

<!-- [ block1 : search conditions ] start -->			
			<%@ include file="/WEB-INF/admin/order/order-payment-searchconditions.jsp" %>
<!-- [ block1 : search conditions ] end -->

<!-- [ block2 : Buttons ] start -->
			<%@ include file="/WEB-INF/admin/order/order-common-block2-buttons.jsp" %>
<!-- [ block2 : Buttons ] end -->

<!-- [ block3 : table header ] start -->
<!-- [ block3-1 : title ] start -->
			<h4 class="mb-2 pt-2 "><b>주문 목록</b></h4>
<!-- [ block3-1 : title ] end -->
			<div class="mb-3">
				<button type="button" class="btn btn-outline-danger btn-sm">입금확인</button>
				<button type="button" class="btn btn-outline-danger btn-sm">주문취소</button>
			</div>
<!-- [ block3-2 : summary ] start -->				
			<div class="mb-2 d-flex justify-content-between align-items-center">
				<div class="flex-grow-1">
				[조회된 주문건수 총 <span id="searchResults">0</span>건]
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

<!-- [ block4 :Unpaid Order List ] start -->
			<div class="col-sm-12">
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
<!-- [ block4 :Unpaid Order List ] end -->

<!-- [ block5 : table bottom ] start -->
<!-- [ block5-1 : Order Delete ] start -->
						<div class="mb-3">
							<button type="button" class="btn btn-outline-danger btn-sm">결제확인</button>
							<button type="button" class="btn btn-outline-danger btn-sm">주문취소</button>
						</div>
<!-- [ block5-1 : Order Delete ] end -->
<!-- [ block5-2 : Pagination ] start -->				
						<div id = "pagination"></div>
<!-- [ block5-2 : Pagination ] END -->
<!-- [ block5 : table bottom ] end -->
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- [ Main Content ] end -->

<!-- [Page Specific JS] start -->
	<script src="/static/assets/js/plugins/simple-datatables.js"></script>
  	<!-- DatePicker js -->
	<script src="/static/assets/js/plugins/datepicker-full.min.js"></script>
	<script src="/static/js/admin/order/order-payment.js"></script>

<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>