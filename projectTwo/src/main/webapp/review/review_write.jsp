<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@include file="/security/login_check.jspf"%> --%>

<html>
<head>
<title>리뷰 작성</title>
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

#subjectForm {
	width: 382px;
}

#review_sbject {
	text-align: center;
	font-size: 40px;
	color: pink;
}

.button-group {
	display: center;
}

#saveBtn, #resetBtn {
	font-size: 20px;
	border-radius: 5px;
	background-color: pink;
	margin-left: 10px;
	padding: 10px 15px;
	width: 120px;
}

.star-rating {
	font-size: 30px;
	color: #black;
	cursor: pointer;
}

.star-rating .checked {
	color: gold ;
}
</style>

<script>
        function setRating(rating) {
            const stars = document.querySelectorAll('.star');
            document.getElementById('ratingValue').value = rating;
            stars.forEach((star, index) => {
                if (index < rating) {
                    star.classList.add('checked');
                } else {
                    star.classList.remove('checked');
                }
            });
        }

        document.addEventListener('DOMContentLoaded', function () {
            setRating(1); // 
        });
    </script>
</head>
<body>
	<h1 id="review_subject">REVIEW</h1>
	<form
		action="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_writer_action"
		method="post" enctype="multipart/form-data" id="reviewForm">
		<table>
			<tr>
				<td>만족도:</td>
				<td>
					<div class="star-rating">
						<span class="star" onclick="setRating(1)">★</span> <span
							class="star" onclick="setRating(2)">★</span> <span class="star"
							onclick="setRating(3)">★</span> <span class="star"
							onclick="setRating(4)">★</span> <span class="star"
							onclick="setRating(5)">★</span>
					</div> <input type="hidden" name="review_rating" id="ratingValue">
				</td>
			</tr>
			<tr>
				<td>제목:</td>
				<td><input type="text" name="review_subject" id="subjectForm"
					required></td>
			</tr>
			<tr>
				<td>내용:</td>
				<td><textarea name="review_content" rows="5" cols="50" required></textarea></td>
			</tr>
			<tr>
				<td>이미지:</td>
				<td><input type="file" name="review_image"></td>
			</tr>
			<tr>
				<th colspan="2" class="button-group">
					<button type="submit" id="saveBtn">글저장</button>
					<button type="reset" id="resetBtn">다시쓰기</button>
				</th>
			</tr>
		</table>
	</form>
</body>
</html>
<script type="text/javascript">
$("#saveBtn").change(function() {
    //alert($("#reviewCount").val());
    location.href="<%=request.getContextPath()%>/index.jsp?group=review&worker=review_list"
});
</script>
