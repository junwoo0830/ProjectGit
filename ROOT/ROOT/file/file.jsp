<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <title>파일 업로드 폼</title>
</head>
 
<body>
 
<form name="fileForm" id="fileForm" method="POST" action="upload.jsp" enctype="multipart/form-data">
    <input type="text" name="title" id="title">
    <input type="file" name="uploadFile" id="uploadFile">
    <input type="submit" value="전송">
</form>
</body>
</html>
