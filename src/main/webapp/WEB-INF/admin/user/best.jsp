<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
<!-- [Page specific CSS] start -->
<link rel="stylesheet" href="/static/css/admin/user/best.css">
<!-- DatePicker 먼저 로드하고 그다음에 유저를 로드해야합니다. -->
<script src="/static/assets/js/plugins/bootstrap-datepicker.min.js"></script>
 <script src="/static/js/admin/user/best.js"></script>
 
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
              <h2 class="mb-0">구매액 상위 회원 조회<button type="button" class="btn btn-icon btn-link-primary avtar-xs" data-bs-toggle="popover" 
              data-bs-title="구매액 상위 회원 조회"  data-bs-placement="bottom" data-bs-html="true"
              data-bs-content="
              <ul>
                <li>쇼핑몰 구매액이 높은 회원을 조회할 수 있습니다.</li>
							<li>구매액 상위 회원에 대한 관리를 통해 지속적인 구매 유도 및 충성고객 확보 효과를 기대할 수 있습니다.</li>
							<li>조회 시 기준은 총 주문금액 또는 총 실결제금액 중 선택할 수 있습니다.</li>
              </ul>">
              <i class="ti ti-info-circle"></i></button></h2>
              
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- [ page title ] end -->
    
    <div class="row">
      
      <!-- [ block1 : 구매액 상위 회원 조회 ] start -->
      <div class="col-lg-3">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <div class="mb-4">
              <label class="form-label">기간:</label><br/>
              <div class="text-center">
                <div class="btn-group mb-3" role="group">
									<input type="radio" class="btn-check" id="all" name="period" value="999">
									<label class="btn btn-outline-info" for="all">전체</label>
									<input type="radio" class="btn-check" id="today" name="period" value="0">
									<label class="btn btn-outline-info" for="today">오늘</label>
									<input type="radio" class="btn-check" id="three" name="period" value="2">
									<label class="btn btn-outline-info" for="three">3일</label>
									<input type="radio" class="btn-check" id="seven" name="period" value="6">
									<label class="btn btn-outline-info" for="seven">7일</label>
									<input type="radio" class="btn-check" id="month" name="period" value="29">
									<label class="btn btn-outline-info" for="month">30일</label>
								</div>
							</div>
	            <div class="input-daterange input-group" id="datepicker_range">
						    <input type="text" class="input-sm form-control" name="range-start" placeholder="시작일"/>
						    <input type="text" class="input-sm form-control" name="range-end"  placeholder="종료일"/>
							</div>
            </div>
            <div class="text-center">
              <button type="button" class="btn btn-primary" onclick="getList()">검색</button>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block1 : 구매액 상위 회원 조회 ] end -->
      
      <!-- [ block2 : 구매액 상위 회원 목록 ] start -->
      <div class="col-lg-9">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <h4 class="mb-2 pt-2 ">구매액 상위 회원 목록</h4>
            <div class="mb-2 d-flex justify-content-between align-items-center">
              <div class="flex-grow-1">
              	[총 회원수 <span class="totalResults"></span>명] 검색결과 <span class="totalResults"></span>건
              </div>
              <select class="form-select form-select-sm width-120px" id="countPerPage" onchange="setCount(this)">
               <option value="10">10개씩 보기</option>
               <option value="20">20개씩 보기</option>
               <option value="30">30개씩 보기</option>
               <option value="40">40개씩 보기</option>
               <option value="50">50개씩 보기</option>
               <option value="100">100개씩 보기</option>
               <option value="200">200개씩 보기</option>
               <option value="500">500개씩 보기</option>
               <option value="1000">1000개씩 보기</option>
             </select>
            </div>
            
            <div class="table-responsive">
             <table class="table  table-bordered align-middle table-responsive" id="best">
               <thead class="text-center">
                 <tr>
                   <th scope="col">번호</th>
                   <th scope="col">순위</th>
                   <th scope="col">이메일</th>
                   <th scope="col">이름</th>
                   <th scope="col">휴대폰번호</th>
                   <th scope="col">주소</th>
                   <th scope="col">기간내 총 주문금액</th>
                 </tr>
               </thead>
               <tbody class=" " id="list">
               </tbody>
             </table>
              <!-- [ Pagination ] start -->        
              <nav id="pagination" aria-label="Page navigation example"></nav>
              <!-- [ Pagination ] end -->
            </div>
            <div class="no-result text-center mt-5 mb-5 visually-hidden">
              검색된 회원 내역이 없습니다.
            </div>
          </div>
        </div>
      </div>
      <!-- [ block3 : done ] end -->
      
    </div>
  </div>
</div>
<!-- [ Main Content ] end -->
<!-- [Page Specific JS] start -->
<script src="/static/assets/js/plugins/simple-datatables.js"></script>

<!-- [Page Specific JS] end -->
<script>
document.addEventListener('DOMContentLoaded', function () {
  init2();
});

function init2(){
  if (typeof $.fn.datepicker !== 'undefined') {
    console.log("Bootstrap Datepicker is loaded!");
  } else {
    console.log("Bootstrap Datepicker is not loaded.");
  }
  $('#datepicker_range').datepicker({
    format: "yyyymmdd"
  });
}
</script>
<%@ include file="/WEB-INF/admin/common/footer.jsp" %>