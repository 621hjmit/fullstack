<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- [Page specific CSS] start -->
	<!-- Bootstrap DatePicker -->
	<link rel="stylesheet" href="/static/assets/css/plugins/datepicker-bs5.min.css">
<!-- [Page specific CSS] end -->

				<div class="col-sm-12">
					<div class="card table-card">
						<div class="card-body p-3">
<!---------------------------------------------- common ------------------------------------------------------>
<%@ include file="/WEB-INF/admin/order/order-common-block1.jsp" %>
<!---------------------------------------------- common ------------------------------------------------------>														
							<label class="form-label pt-3">배송상태:</label>
							<form class="row row-cols-md-auto g-1 align-items-center">
								<div class="col-12">
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="deliveryStatus" value="5" id="radio5" checked>
										<label for="radio5">상품준비중</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="deliveryStatus" value="6" id="radio6">
										<label for="radio6">배송준비중</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="deliveryStatus" value="7" id="radio7">
										<label for="radio7">배송중</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="deliveryStatus" value="8" id="radio8">
										<label for="radio8">배송완료</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="deliveryStatus" value="9" id="radio9">
										<label for="radio9">배송보류</label>
									</div>
								</div>
							</form>
						</div>
            		</div>
				</div>
