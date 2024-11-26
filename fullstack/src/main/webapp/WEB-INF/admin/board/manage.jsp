<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/admin/common/header.jsp" %>
<!-- [Page specific CSS] start -->
<link rel="stylesheet" href="/static/css/admin/board/manage.css">
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
              <h2 class="mb-0">1:1 문의</h2>
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
              <label class="form-label">게시글 찾기:</label>
              <select class="form-select form-select-sm mb-2" id="searchType">
                <option value="1">제목</option>
                <option value="2">내용</option>
                <option value="3">성</option>
                <option value="4">이름</option>
                <option value="5">이메일</option>
                <option value="6">휴대폰번호</option>
              </select>
              <input class="form-control form-control-sm" type="text" placeholder="" id="searchText">
            </div>
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
            <div class="mb-4">
              <label class="form-label">답변상태:</label><br>
              <div class=" text-center">
	              <div class="btn-group" role="group">
	                <input type="radio" class="btn-check" id="replyStatusAll" name="replyStatus" value="3">
	                <label class="btn btn-outline-info" for="replyStatusAll">전체보기</label>
	                <input type="radio" class="btn-check" id="replyStatusBefore" name="replyStatus" value="0">
	                <label class="btn btn-outline-info" for="replyStatusBefore">미답변</label>
	                <input type="radio" class="btn-check" id="replyStatusAfter" name="replyStatus" value="1">
	                <label class="btn btn-outline-info" for="replyStatusAfter">답변완료</label>
	              </div>
              </div>
            </div>
            <div class="text-center">
              <button type="button" class="btn btn-primary" onclick="search()">검색</button>
            </div>
          </div>
        </div>
      </div>
      <!-- [ block1 : 회원 현황 ] end -->
      
      <!-- [ block2 : 최근 가입 회원 ] start -->
      <div class="col-lg-9">
        <div class="card table-card">
          <div class="card-body p-4 ">
            <h4 class="mb-2 pt-2 ">1:1 문의 목록
              <button type="button" class="btn btn-icon btn-link-primary avtar-xs" data-bs-toggle="popover" 
              data-bs-title="회원 목록"  data-bs-placement="bottom" data-bs-html="true"
              data-bs-content="
              <ul>
                <li>삭제 시 회원의 미완료 주문 여부, 적립금 여부를 확인하며 미완료 주문이 있는 경우 삭제되지 않습니다.</li>
                <li>[자세히보기]를 체크하면 각 회원의 적립금, 예치금, 접속, 주문, 총 주문금액, 총 실결제금액을 확인할 수 있습니다.</li>
                <li>해당 기능은 100개 이하 목록에서는 바로 확인할 수 있으며, 200개 이상은 [관련 내역 보기]의 각 버튼을 통해 확인할 수 있습니다.</li>
                <li>휴면회원의 개인정보는 분리, 보관되어 쇼핑몰 관리자의 '고객관리 > 회원관리 > 휴면회원 관리'에서 별도로 조회할 수 있으며, 휴면회원이 로그인시 자동으로 휴면해제가 됩니다.</li>
                <li>일반전화 또는 스마트폰 아이콘을 클릭하면 전화상담메모 창을 띄웁니다.</li>
              </ul>">
              <i class="ti ti-info-circle"></i></button>
            </h4>
            <div class="mb-2 d-flex justify-content-between align-items-center">
              <div class="flex-grow-1">
                [총 게시글수 <span class="totalResults"></span>개] 검색결과 <span class="totalResults"></span>건
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
            <div class="mb-3">
              <button type="button" class="btn btn-outline-danger btn-sm" onclick="deleteSelected()">삭제</button>
            </div>
            <div class="table-responsive" id="dataTable">
              <table class="table  table-bordered align-middle">
                <thead class="text-center">
                  <tr>
                    <th scope="col"><input type="checkbox" onclick="check_all('check', this);" class="allChk"></th>
                    <th scope="col">번호</th>
                    <th scope="col">분류</th>
                    <th scope="col">제목</th>
                    <th scope="col">답변상태</th>
                    <th scope="col">글 보기</th>
                    <th scope="col">답변하기</th>
                    <th scope="col">작성자</th>
                    <th scope="col">작성일</th>
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
              검색된 회원 내역이 없습니다.
            </div>
            <div class="mb-3">
              <button type="button" class="btn btn-outline-danger btn-sm" onclick="delete()">삭제</button>
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
<script src="/static/assets/js/plugins/popper.min.js"></script>
<script src="/static/assets/js/plugins/bootstrap.min.js"></script>
<script src="/static/assets/js/plugins/bootstrap-datepicker.min.js"></script>
<script src="/static/js/admin/board/manage.js"></script>
<!-- [Page Specific JS] end -->

<%@ include file="/WEB-INF/admin/common/footer.jsp" %>