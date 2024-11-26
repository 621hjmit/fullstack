<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
<!-- [Page specific CSS] start -->
<!-- DatePicker 먼저 로드하고 그다음에 유저를 로드해야합니다. -->
<script src="/static/assets/js/plugins/bootstrap-datepicker.min.js"></script>
 <script src="/static/js/admin/user/out.js"></script>
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
              <h2 class="mb-0">회원 탈퇴 관리<button type="button" class="btn btn-icon btn-link-primary avtar-xs" data-bs-toggle="popover" 
              data-bs-title="회원 탈퇴 관리"  data-bs-placement="bottom" data-bs-html="true"
              data-bs-content="
              <ul>
                <li>직접 탈퇴하거나 또는 운영 방침에 따라 강제 탈퇴된 회원을 확인할 수 있습니다.</li>
                <li>회원 탈퇴 처리 시 개인 정보가 삭제되며 복구할 수 없습니다.</li>
                <li>탈퇴 처리는 일반탈퇴, 강제탈퇴, 탈퇴신청, 인증삭제로 구분됩니다.</li>
              </ul>">
              <i class="ti ti-info-circle"></i></button></h2>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- [ page title ] end -->
    
    <div class="row">
      
      <!-- [ block1 : 회원 검색 ] start -->
      <div class="col-lg-3">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <div class="mb-4">
            	<label class="form-label">회원등급:</label>
              <select class="form-select form-select-sm mb-2 " id="searchGrade">
              </select>
            </div>
            <div class="mb-4">
              <label class="form-label">이메일:</label>
						<input type="text" class="form-control form-control-sm" id="searchEmail">                
            </div>
            <div class="mb-4">
              <label class="form-label">탈퇴유형:</label>
              <select class="form-select form-select-sm mb-2 " id="searchOutType">
                <option value="0">전체</option>
                <option value="1">일반탈퇴</option>
                <option value="2">강제탈퇴</option>
              </select>          
            </div>
            <div class="mb-4">
              <label class="form-label">기간:</label><br/>
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
							<input type="radio" class="btn-check" id="year" name="period" value="364">
							<label class="btn btn-outline-info" for="year">1년</label>
						</div>
						<div class="input-daterange input-group " id="datepicker_range">
                <input type="text" class="form-control text-left" placeholder="시작일" name="range-start" >
                <input type="text" class="form-control text-end" placeholder="종료일" name="range-end" >
              </div>
            </div>
            <div class="mb-4">
              <label class="form-label">탈퇴사유:</label>
              <select class="form-select form-select-sm mb-2 " id="searchOutDesc">
              </select>          
            </div>
            <div class="text-center">
              <button type="button" class="btn btn-primary" onclick="getList()">검색</button>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block1 : 회원 검색 ] end -->
      
      <!-- [ block2 : 회원 목록 ] start -->
      <div class="col-lg-9">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <h4 class="mb-2 pt-2 ">탈퇴 회원 목록</h4>
            <div class="mb-2 d-flex justify-content-between align-items-center">
              <div class="flex-grow-1">
              	[총 회원수 <span class="totalResults"></span>명] 검색결과 <span class="totalResults"></span>건
              	<button class="btn btn-icon btn-link-warning avtar-xs"><i class="ph-duotone ph-star"></i></button>특별관리회원
              	<button class="btn btn-icon btn-link-danger avtar-xs"><i class="ph-duotone ph-warning-circle"></i></button>불량회원
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
              <table class="table  table-bordered align-middle">
               <thead class="text-center">
                 <tr>
                   <th scope="col">가입날짜</th>
                   <th scope="col">탈퇴날짜</th>
                   <th scope="col">이름</th>
                   <th scope="col">이메일</th>
                   <th scope="col">등급</th>
                   <th scope="col">성별</th>
                   <!-- <th scope="col">메일/SMS/메모</th> -->
                   <th scope="col">주문 내역 보기</th>
                 </tr>
               </thead>
               <tbody class="text-center " id="userList">
               </tbody>
             </table>
             <!-- [ Pagination ] start -->        
             <nav id="pagination" aria-label="Page navigation example"></nav>
             <!-- [ Pagination ] end -->
            </div>
            <div class="no-result text-center mt-5 mb-5 visually-hidden">
              검색된 주문 회원 내역이 없습니다.
            </div>
          </div>
        </div>
      </div>
      <!-- [ block2 : 회원 목록 ] end -->
      <!-- [ block3 : 추가 설정 ] start -->
      <div class="col-lg-12">
        
      </div>
      <!-- [ block3 : 추가 설정 ] end -->
    </div>
  </div>
</div>
<!-- [ Main Content ] end -->
<!-- [Page Specific JS] start -->
<script src="/static/assets/js/plugins/simple-datatables.js"></script>
<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>