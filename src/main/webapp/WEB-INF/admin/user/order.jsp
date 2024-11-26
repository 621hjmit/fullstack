<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
<!-- [Page specific CSS] start -->
<!-- Bootstrap DatePicker -->
<link rel="stylesheet" href="/static/assets/css/plugins/datepicker-bs5.min.css">
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
              <h2 class="mb-0">주문 회원 조회<button type="button" class="btn btn-icon btn-link-primary avtar-xs" data-bs-toggle="popover" 
              data-bs-title="주문 회원 조회"  data-bs-placement="bottom" data-bs-html="true"
              data-bs-content="
              <ul>
                <li>쇼핑몰 회원을 주문 회원, 주문하지 않은 회원, 특별관리 회원으로 구분하여 조회할 수 있습니다.</li>
							<li>특별관리 회원은 [회원 정보 조회 > 회원 상세 정보] 에서 '특별관리 회원' 항목에 체크되어있는 회원을 의미합니다. 이 화면에서는 특별관리 회원 중에서도 주문내역이 있는 회원만 조회됩니다.</li>
							<li>구매금액과 구매건수는 최솟값 또는 최댓값만 입력 가능합니다.</li>
              </ul>">
              <i class="ti ti-info-circle"></i></button></h2>
              
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- [ page title ] end -->
    
    <div class="row">
      
      <!-- [ block1 : 회원 현황 ] start -->
      <div class="col-lg-3">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <div class="mb-4">
              <label class="form-label">회원구분:</label><br/>
              <div class="btn-group mb-4" role="group" id="userType">
							<input type="radio" class="btn-check" id="userOrdered" name="memberType" value="">
							<label class="btn btn-outline-info" for="userOrdered">주문회원</label>
							<input type="radio" class="btn-check" id="userUnordered" name="memberType" value="2">
							<label class="btn btn-outline-info" for="userUnordered">주문 안한 회원</label>
							<input type="radio" class="btn-check" id="userVip" name="memberType" value="0">
							<label class="btn btn-outline-info" for="userVip">특별관리회원</label>
						</div>
            	<label class="form-label">회원등급:</label>
              <select class="form-select form-select-sm mb-2 " id="searchGrade">
              </select>
             <label class="form-label">성:</label>
              <div class="input-group mb-3">
                <input type="text" class="form-control form-control-sm" id="userLastName">
              </div>
              <label class="form-label">이름:</label>
              <div class="input-group mb-3">
						  <input type="text" class="form-control form-control-sm" id="userFirstName">
						</div>
              <label class="form-label">이메일:</label>
              <div class="input-group mb-3">
						  <input type="text" class="form-control form-control-sm" id="userEmail">
						</div>
              <label class="form-label">휴대폰번호:</label>
              <div class="input-group mb-3">
                <input type="text" class="form-control form-control-sm" id="userPhone">
              </div>
              <label class="form-label">주문번호:</label>
              <div class="input-group mb-3">
						  <input type="text" class="form-control form-control-sm" id="userOrderID">
						</div>
             <div class="text-center">
               <button type="button" class="btn btn-primary" onclick="search()">검색</button>
             </div>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block1 : 회원 현황 ] end -->
      
      <!-- [ block2 : 최근 가입 회원 ] start -->
      <div class="col-lg-9">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <h4 class="mb-2 pt-2">주문 회원 목록</h4>
            <div class="mb-2 d-flex justify-content-between align-items-center">
              <div class="flex-grow-1">
              	[총 회원수 1명] 검색결과 1건
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
             <table class="table  table-bordered align-middle ">
               <thead class="text-center">
                 <tr>
                   <th scope="col"><input type="checkbox" onclick="check_all('use_check[]', this);" class="allChk"></th>
                   <th scope="col">최근 주문일</th>
                   <th scope="col">이름</th>
                   <th scope="col">이메일</th>
                   <th scope="col">등급</th>
                   <th scope="col">타입</th>
                   <th scope="col">최근 주문번호</th>
                   <th scope="col">총 주문 금액</th>
                   <th scope="col">총 주문 건수</th>
                   <!--<th scope="col">메일/SMS/메모</th> -->
                   <th scope="col">메모</th>
                 </tr>
               </thead>
               <tbody class="text-center " id="orderUserList">
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
      <!-- [ block3 : done ] end -->
      
    </div>
  </div>
</div>
<!-- [ Main Content ] end -->
<!-- [ Modal Content ] start -->
<div id="modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header" >
        <h5 class="modal-title">게시글 내용 미리보기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="modal-body"></div>
      <div class="modal-footer">
        
      </div>
    </div>
  </div>
</div>
<!-- [ Modal Content ] end -->
<!-- [Page Specific JS] start -->
<script src="/static/assets/js/plugins/simple-datatables.js"></script>
<script src="/static/js/admin/user/order-user.js"></script>
<script src="/static/js/admin/user/memo.js"></script>
<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>