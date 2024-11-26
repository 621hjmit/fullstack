<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>

<!-- [ Main Content ] start -->
<div class="pc-container">
  
	<div class="pc-content">
    <!-- [ page title ] start -->
		<div class="page-header">
			<div class="page-block">
				<div class="row align-items-center">
					<div class="col-md-12">
						<div class="page-header-title">
							<h2 class="mb-0">주문 대쉬보드</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
<!-- [ page title ] end -->

<div class="row">
<!-- [ block1 : 실시간 매출 현황 ] start -->
		<div class="col-sm-12">
			<div class="card table-card">
				<div class="card-body p-4 ">
					<div class="d-flex flex-row  align-items-end">
						<h4 class="mb-0 p-2 ">실시간 매출 현황</h4>
					</div>
					
					<div class="row">
						<table class="table col-md-12">
							<thead>
								<tr>
									<th scope="col" class="text-end col-3">구분</th>
									<th scope="col" class="text-end col-3">오늘</th>
									<th scope="col" class="text-end col-3">이번 달</th>
									<th scope="col" class="text-center col-3">바로가기</th>
								</tr>
							</thead>
							
							<tbody class="table-group-divider">
								<tr class="text-end">
									<th scope="row">
										<span>총 주문 금액
											<button type="button" class="btn btn-icon btn-link-primary avtar-xs" data-bs-toggle="popover" 
										    data-bs-title="총 주문 금액"  data-bs-placement="bottom" data-bs-html="true"
										    data-bs-content="
											<ul>
												<li>총 주문 금액(건수)</li>
												<li>총 주문 금액(건수)는 해당 기간 내 발생한 주문의 금액 및 건수를 집계한 현황입니다.</li>
												<li>총 주문 금액에는 상품구매금액 및 배송비가 포함되어 있으며, 취소, 교환, 반품 시 반품배송비 등으로 인한 배송비 변동액도 포함하여 집계됩니다.</li>
												<li>주문조회 버튼 클릭 시 [주문 > 전체 주문 조회]로 이동하여 총 주문 목록을 확인할 수 있습니다.</li>
											</ul>">
												<i class="ti ti-info-circle"></i>
											</button>
										</span>
									</th>
									<td>
										<div>
											<a href="#"><span id="totalAmountToday">0</span>원</a>
										</div>
										<div>
											<span id="totalCountToday">0</span>건
										</div>
									</td>
									<td>
										<div>
											<a href="#"><span id="totalAmountMonth">0</span>원</a>
										</div>
										<div>
											<span id="totalCountMonth">0</span>건
										</div>
									</td>
									<td class="text-center">
										<a href="/admin/order/order-management" class="btn btn-light-primary">주문조회</a>
									</td>
								</tr>
							
								
								<tr class="text-end">
									<th scope="row">
										<span>총 환불 금액
											<button type="button" class="btn btn-icon btn-link-primary avtar-xs" data-bs-toggle="popover" 
											    data-bs-title="총 환불 금액"  data-bs-placement="bottom" data-bs-html="true"
											    data-bs-content="
											<ul>
												<li>총 환불 금액(건수)</li>
												<li>총 환불금액(건수)는 취소, 교환, 반품에 의해 고객에게 환불된 금액과 건수 합계 정보를 집계한 현황입니다.</li>
												<li>환불 금액은 실제 고객에게 환불처리된 실 환불 금액 정보를 의미합니다.</li>
												<li>환불조회 버튼 클릭 시 [주문 > 취소/교환/반품/환불 > 환불 관리]로 이동하여 환불 목록을 확인할 수 있습니다.</li>
											</ul>">
												<i class="ti ti-info-circle"></i>
											</button>
										</span>
									</th>
									<td>
										<div>
											<a href="#"><span id="refundAmountToday">0</span>원</a>
										</div>
										<div>
											<span id="refundCountToday">0</span>건
										</div>
									</td>
									<td>
										<div>
											<a href="#"><span id="refundAmountMonth">0</span>원</a>
										</div>
										<div>
											<span id="refundCountMonth">0</span>건
										</div>
									</td>
									<td class="text-center">
										<a href="/admin/order/order-refund" class="btn btn-light-primary">환불조회</a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
<!-- [ block1 : 실시간 매출 현황 ] end -->

<!-- [ block2 : 미 완료 주문 현황 ] start -->
		<div class="col-sm-12">
			<div class="card table-card">
				<div class="card-body p-4 ">
					<h4 class="mb-0 p-2 ">처리할 주문 현황</h4>
					<table class="table  table-bordered">
						<thead class="text-center">
							<tr>
								<th scope="col">미처리 주문
									<button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
									data-bs-title="신규주문"  data-bs-placement="bottom"
									data-bs-content="결제완료되었으나, 아직 처리되지 않은 주문">
									<i class="ti ti-info-circle"></i></button>
								</th>
								<th scope="col">상품준비중
									<button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
									data-bs-title="상품준비중"  data-bs-placement="bottom"
									data-bs-content="결제가 완료되어 배송을 위해 상품을 준비중인 건">
									<i class="ti ti-info-circle"></i></button>
								</th>
								<th scope="col">배송준비중
									<button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
									data-bs-title="배송준비중"  data-bs-placement="bottom"
									data-bs-content="제품이 확보되어 배송 준비중인 주문">
									<i class="ti ti-info-circle"></i></button>
								</th>
								<th scope="col">배송보류
									<button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
									data-bs-title="배송보류"  data-bs-placement="bottom"
									data-bs-content="고객의 사유로 배송이 보류된 주문">
									<i class="ti ti-info-circle"></i></button>
								</th>
								<th scope="col">배송중
									<button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
									data-bs-title="배송중" data-bs-html="true" data-bs-placement="bottom"
									data-bs-content="운송장이 입력되고 배송사로 제품이 이관된 건">
									<i class="ti ti-info-circle"></i></button>
								</th>
							</tr>
						</thead>
						<tbody class="text-end">
							<tr>
								<td><strong class="text-decoration-underline fs-4" id="newOrder">0</strong> 건</td>
								<td><strong class="text-decoration-underline fs-4" id="prepProduct">0</strong> 건</td>
								<td><strong class="text-decoration-underline fs-4" id="prepDelivery">0</strong> 건</td>
								<td><strong class="text-decoration-underline fs-4" id="holdDelivery">0</strong> 건</td>
								<td><strong class="text-decoration-underline fs-4" id="onDelivery">0</strong> 건</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
<!-- [ block2 : 미 완료 주문 현황 ] end -->

<!-- [ block3 : C/S 현황 ] start -->      
		<div class="col-sm-12">
			<div class="card table-card">
				<div class="card-body p-4 ">
					<h4 class="mb-0 p-2 ">C/S 현황</h4>
					<table class="table  table-bordered">
						<thead class="text-center">
							<tr>
								<th scope="col">장기 미결 주문
									<button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
									data-bs-title="장기미결주문"  data-bs-placement="bottom"
									data-bs-content="판매자 사유로 주문일 15일 경과후 미발송 주문건">
									<i class="ti ti-info-circle"></i></button>
								</th>
								<th scope="col">취소 처리중
									<button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
									data-bs-title="취소 처리중인 주문 건"  data-bs-placement="bottom"
									data-bs-content="고객 요청 또는 판매자 사유에 의해 취소 절차중인 주문">
									<i class="ti ti-info-circle"></i></button>
								</th>
								<th scope="col">교환 처리중
									<button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
									data-bs-title="교환 처리 중 주문"  data-bs-placement="bottom"
									data-bs-content="결제금액 변동 없이 교환 처리중인 주문">
									<i class="ti ti-info-circle"></i></button>
								</th>
								<th scope="col">반품 처리중
									<button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
									data-bs-title="반품처리중"  data-bs-placement="bottom"
									data-bs-content="반품 진행중인 주문">
									<i class="ti ti-info-circle"></i></button>
								</th>
								<th scope="col">환불 처리중
									<button type="button" class="btn btn-icon btn-light-info" data-bs-toggle="popover" 
									data-bs-title="환불 처리중인 주문" data-bs-html="true" data-bs-placement="bottom"
									data-bs-content="환불처리중인 주문">
									<i class="ti ti-info-circle"></i></button>
								</th>
							</tr>
						</thead>
						<tbody class="text-end">
							<tr>
								<td><strong class="text-decoration-underline fs-4" id="pendingOrder">0</strong> 건</td>
								<td><strong class="text-decoration-underline fs-4" id="cancleOrder">0</strong> 건</td>
								<td><strong class="text-decoration-underline fs-4" id="exchangeOrder">0</strong> 건</td>
								<td><strong class="text-decoration-underline fs-4" id="returnOrder">0</strong> 건</td>
								<td><strong class="text-decoration-underline fs-4" id="refundOrder">0</strong> 건</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
 <!-- [ block3 : C/S 현황 ] end -->
    </div>
  </div>
</div>
<!-- [ Main Content ] end -->

<!-- [ Modal ] end -->
<!-- [Page Specific JS] start -->
<script src="/static/js/admin/order/order-dashboard.js"></script>
<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>