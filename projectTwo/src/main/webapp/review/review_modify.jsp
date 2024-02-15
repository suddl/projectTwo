<%@page import="xyz.nailro.dao.ReviewDAO"%>
<%@page import="xyz.nailro.dto.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 REVIEW 테이블의 저장된 행(게시글)을 검색하여 입력태그의 입력값으로
출력하고 변경값을 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 상태의 사용자 중 게시글 작성자이거나 관리자인 경우에만 요청 가능한 JSP 문서 --%>    
<%-- => [글변경] 태그를 클릭한 경우 [/review/review_modify_action.jsp] 문서를 요청하여 페이지 이동 - 입력값(게시글) 전달 --%>
<%-- 비로그인 상태의 사용자가 JSP 문서를 요청한 경우 에러페이지로 이동되도록 응답 처리 --%>
<%@include file="/security/login_check.jspf" %>    
<%
    // 글번호가 전달되지 않은 경우에 대한 응답 처리 - 비정상적인 요청
    if(request.getParameter("reviewNum")==null) {
        request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
        return;
    }
    // 전달값을 반환받아 저장
    int reviewNum = Integer.parseInt(request.getParameter("reviewNum"));
    String pageNum = request.getParameter("pageNum");
    String pageSize = request.getParameter("pageSize");
    String search = request.getParameter("search");
    String keyword = request.getParameter("keyword");
    
    // 글번호를 전달받아 REVIEW 테이블의 단일행을 검색하여 게시글(ReviewDTO 객체)을 반환하는 
    // ReviewDAO 클래스의 메소드 호출
    ///HOTFIX 오류수정 필요
    ReviewDTO review = ReviewDAO.getDAO().selectReviewByNum(reviewNum);
    
    // 검색된 게시글이 없는 경우에 대한 응답 처리 - 비정상적인 요청
    if(review == null) {
        request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
        return;
    }   
    
    // 로그인 상태의 사용자가 게시글 작성자 및 관리자가 아닌 경우에 대한 응답 처리 - 비정상적인 요청
    if(loginClient.getClientNum() != review.getReviewClientNum() && loginClient.getClientStatus() != 9) {
        request.setAttribute("returnUrl", request.getContextPath()+"/index.jsp?group=error&worker=error_400");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글변경</title>
    <style type="text/css">
        table {
            margin: 0 auto;
        }
        th {
            width: 100px;
   			font-weight: bold; 
        }
        td {
            text-align: left;
        }
        .star {
            cursor: pointer;
        }
        .checked {
            color: yellow;
        }
        .star-rating {
    		font-size: 30px;
   		 	color: black;
    		cursor: pointer;
		}
        #reviewSubject {
        	width: 382px;
        }
        #modifyBtn,#resetBtn {
        	font-size: 20px;
    		border-radius: 5px;
    		background-color: pink;
    		margin-left: 10px;
    		padding: 10px 15px;
    		width: 120px;
        }
        #starmessage {
			font-size: 0.5em;
		}
        
    </style>
</head>
<body>
    <h1>리뷰변경</h1>
    <%-- 파일(리뷰 이미지)을 입력받아 전달하기 위해 form 태그의 enctype 속성값을 반드시 [multipart/form-data]로 설정 --%>
    <form action="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_modify_action"
        method="post" enctype="multipart/form-data" id="reviewForm">
        <input type="hidden" name="reviewNum" value="<%=reviewNum %>">
        <input type="hidden" name="pageNum" value="<%=pageNum %>">
        <input type="hidden" name="pageSize" value="<%=pageSize %>">
        <input type="hidden" name="search" value="<%=search %>">
        <input type="hidden" name="keyword" value="<%=keyword %>">
        <table>
        	 <tr>
                <td>별점</td>
                <td>
                    <div class="star-rating">
                        <span class="star" onclick="setRating(1)">☆</span>
                        <span class="star" onclick="setRating(2)">☆</span>
                        <span class="star" onclick="setRating(3)">☆</span>
                        <span class="star" onclick="setRating(4)">☆</span>
                        <span class="star" onclick="setRating(5)">☆</span>
                    	<div id="starmessage" style="color: red;">별점을 다시 체크해주세요!</div>
                    </div> 
                    <input type="hidden" name="reviewRating" id="ratingValue">
                </td>
            </tr>
            <tr>
                <td>제목</td>
                <td>
                    <input type="text" name="reviewSubject" id="reviewSubject" size="40" 
                        value="<%=review.getReviewSubject()%>">
                </td>                   
            </tr>   
            <tr>
                <td>내용</td>
                <td>
                    <textarea rows="7" cols="60" name="reviewContent" id="reviewContent"><%=review.getReviewContent() %></textarea>
                </td>
            </tr>           
            <tr>
                <td>이미지파일</td>
                <td>
                    <input type="file" name="reviewImage"><br><br>
                    <% if(review.getReviewImage()!=null) { %>
                        <div style="color: red;">이미지를 변경할 경우에만 파일을 입력해 주세요.</div>
                        <img src="<%=request.getContextPath()%>/<%=review.getReviewImage()%>" width="200">
                    <% } %>
                </td>
            </tr>
            <tr>
                <th colspan="2">
                    <button type="submit" id="modifyBtn">글변경</button>
                    <button type="reset" id="resetBtn">다시쓰기</button>
                </th>
            </tr>
        </table>
    </form>
    <div id="message" style="color: red;"></div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script type="text/javascript">
        $("#reviewSubject").focus();
        
        // 별점을 설정하는 함수
        function setRating(rating) {
            const stars = document.querySelectorAll('.star');
            let starsText = '';
            for (let i = 0; i < rating; i++) {
                starsText += '★';
            }
            // ★ 문자열을 숨겨진 필드에 저장
            document.getElementById('ratingValue').value = starsText;

            // 별 표시 업데이트
            stars.forEach((star, index) => {
                if (index < rating) {
                    star.textContent = '★'; 
                    star.classList.add('checked');
                } else {
                    star.textContent = '☆';
                    star.classList.remove('checked');
                }
            });
        }

        // 페이지 로드 시 별점 초기화
        document.addEventListener('DOMContentLoaded', function () {
            const currentRating = document.getElementById('ratingValue').value.length; // ★ 문자열의 길이를 통해 현재 별점 계산
            setRating(currentRating);
        });

        // 별 클릭 이벤트 처리
        document.querySelectorAll('.star').forEach((star, index) => {
            star.addEventListener('click', () => {
                setRating(index + 1); // 클릭한 별에 해당하는 별점 설정
            });
        });

        // 폼 제출 전 유효성 검사
        $("#reviewForm").submit(function() {
            // 이전 유효성 검사 코드 유지...
        });
        
        $("#resetBtn").click(function() {
            $("#reviewSubject").focus();
            $("#message").text("");
        });
    </script>
</body>
</html>