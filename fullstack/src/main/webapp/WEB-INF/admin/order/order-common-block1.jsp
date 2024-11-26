<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			
<!---------------------------------------------- common ------------------------------------------------------>
							<label class="form-label">기간(주문일기준):</label>
							
							<form class="row row-cols-md-auto g-1 align-items-center">
								<div class="col-12">
									<button type="button" onclick="setDate(this)" value="0" class="form-control">오늘</button>
								</div>
								<div class="col-12">
									<button  type="button" onclick="setDate(this)" value="7" class="form-control">7일</button>
								</div>
								<div class="col-12">
									<button  type="button" onclick="setDate(this)" value="15" class="form-control">15일</button>
								</div>
								<div class="col-12">
									<button type="button" onclick="setDate(this)" value="30" class="form-control">1개월</button>
								</div>
								<div class="col-12">
									<button type="button" onclick="setDate(this)" value="90" class="form-control">3개월</button>
								</div>
								<div class="col-12">
									<button type="button" onclick="setDate(this)" value="180" class="form-control">6개월</button>
								</div>
	              
								<div class="col-12">
									<input id="startDate" type="date" class="form-control">
								</div>
								 ~ 
								<div class="col-12">
									<input id="endDate" type="date" class="form-control">
								</div>
							</form>
							<label class="form-label pt-3">검색어:</label>
							<form class="row row-cols-md-auto g-1 align-items-center">
								<div class="col-12">
									<select id="selectCondition" onchange="selectPiCode()" class="form-select" aria-label="Default select example">
										<option value="1" selected>주문번호</option>
										<option value="2">고객명</option>
										<option value="3">입금자명</option>
										<option value="4">수령자명</option>
										<option value="5">상품코드</option>
									</select>
								</div>
								<div class="col-12">
									<div class="input-group">
										<input id="keyword" type="text" class="form-control" placeholder="검색어를 입력하세요">
									</div>
								</div>
							</form>
<!---------------------------------------------- common ------------------------------------------------------>	