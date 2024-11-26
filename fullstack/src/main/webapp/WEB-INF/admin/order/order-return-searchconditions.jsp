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
							<label class="form-label pt-3">CS 상태: </label>
							<form class="row row-cols-md-auto g-1 align-items-center">
								<div class="col-12">
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="returnStatus" value="1" id="radio1">
										<label for="radio1">전체</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="returnStatus" value="2" id="radio2">
										<label for="radio2">반품신청</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="returnStatus" value="3" id="radio3">
										<label for="radio3">반품처리중</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="returnStatus" value="4" id="radio4">
										<label for="radio4">반품완료</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="returnStatus" value="5" id="radio5">
										<label for="radio5">반품보류</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="returnStatus" value="6" id="radio6">
										<label for="radio6">접수거부/철회</label>
									</div>
								</div>
							</form>
						
							<label class="form-label pt-3">결제 수단: </label>
							<form class="row row-cols-md-auto g-1 align-items-center">
								<div class="col-12">
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="payMethod" value="9" id="radio9">
										<label for="radio9">Card</label>
									</div>
									<div class="form-check-inline">
										<input class="form-check-input conditions" type="radio" name="payMethod" value="10" id="radio10">
										<label for="radio10">Cash</label>
									</div>
								</div>
							</form>
						</div>
            		</div>
				</div>
