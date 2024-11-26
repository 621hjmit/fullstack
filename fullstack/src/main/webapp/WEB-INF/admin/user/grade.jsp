<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
<!-- [Page specific CSS] start -->
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
              <h2 class="mb-0">회원 등급별 관리<button type="button" class="btn btn-icon btn-link-primary avtar-xs" data-bs-toggle="popover" 
              data-bs-title="회원등급별 회원관리"  data-bs-placement="bottom" data-bs-html="true"
              data-bs-content="
              <ul>
                <li>회원을 선택하고 '등급해제 '버튼을 누르면, 해당 회원은 기본회원등급(신규가입시 설정되는 등급)으로 변경됩니다.</li>
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
              <label class="form-label">결과 내 검색:</label>
              <select class="form-select form-select-sm mb-2 " id='contactTypeSelect'>
                <option value='0'>이메일</option>
                <option value='1'>성</option>
                <option value='2'>이름</option>
                <option value='3'>휴대폰번호</option>
              </select>
              <div class="input-group mb-3">
						  <input type="text" class="form-control form-control-sm" id="searchText">
               <button type="button" class="btn btn-primary" onclick='search()'>검색</button>
						</div>
            </div>
          </div>
        </div>
        <div class="card table-card">
          <div class="card-body p-4 ">
            <h5 class="mb-4 pt-2">추가 설정</h5>
            <div class="mb-4">
            	<label class="form-label">회원등급 변경:</label><br/>
            	선택된 회원을
              <select class="form-select form-select-sm mb-2 width-120px d-inline-block" id="searchGrade2">
              </select>
              으로 <button type="button" class="btn btn-outline-primary btn-sm " onclick="updateGrades()">등급 변경</button>합니다.
            </div>
          </div>
        </div>
      </div>
      <!-- [ block1 : 회원 검색 ] end -->
      
      <!-- [ block2 : 회원 목록 ] start -->
      <div class="col-lg-9">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <h4 class="mb-2 pt-2 ">등급별 회원 목록</h4>
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
                   <th scope="col"><input type="checkbox" onclick="check_all('check', this);" class="allChk"></th>
                   <th scope="col">등록일</th>
                   <th scope="col">이름</th>
                   <th scope="col">이메일</th>
                   <th scope="col">등급</th>
                   <th scope="col">성별</th>
                   <th scope="col">휴대폰번호</th>
                   <!-- <th scope="col">메일/SMS/메모</th> 
                   <th scope="col">메모</th>-->
                   <th scope="col">주문 내역 보기</th>
                 </tr>
               </thead>
               <tbody class="text-center " id="list">
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
<script src="/static/js/admin/user/grade.js"></script>
<!-- [Page Specific JS] end -->
<%@ include file="/WEB-INF/admin/common/footer.jsp" %>