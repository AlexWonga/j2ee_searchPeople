<%--
  Created by IntelliJ IDEA.
  User: dell
  Date: 2020/10/26
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="pojo.Person" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>searchPeople</title>
    <style type="text/css">
        .frame {
            margin: 100px auto;
            width: 800px;
            /*display: flex;*/
            /*justify-content: center;*/
        }

        .header {
            margin: 0 auto;
        }

        .pagination {
            margin-top: 48px;
            display: flex;
            justify-content: flex-end;
        }

        .pagination button {
            margin-right: 4px;
            padding: 4px;
        }
    </style>
</head>
<body>
<div class="frame">
    <div class="header">

        <h1>
            搜索结果：
        </h1>
    </div>
    <table border="1" cellspacing="0">
        <tr>
            <th>id</th>
            <th>姓名</th>
            <th>联系电话</th>
            <th>qq</th>
            <th>邮箱</th>
        </tr>
        <%
            int pagi = request.getAttribute("page") != null ? (int) (request.getAttribute("page")) : 0;
            int limit = request.getAttribute("limit") != null ? (int) (request.getAttribute("limit")) : 5;
            System.out.println("page" + pagi);
            System.out.println("limit" + limit);
            int start = (pagi - 1) * limit;
            int end = (pagi - 1) * limit + limit;
            List<Person> personList = (List<Person>) request.getAttribute("personList");
            int maxPage = (int) Math.ceil((double) personList.size() / (double) limit);
            System.out.println("maxpage"+maxPage);
            int maxSize = personList.size();
            int readSize = Math.min(maxSize, end);
            for (int i = start; i < readSize; i++) {
        %>
        <tr>
            <td>
                <%=personList.get(i).getId() %>
            </td>
            <td>
                <%=personList.get(i).getName() %>
            </td>
            <td>
                <%=personList.get(i).getTelephone() %>
            </td>
            <td>
                <%=personList.get(i).getQq() %>

            </td>
            <td>
                <%=personList.get(i).getEmail() %>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <div class="pagination">
        <%--        <c:set let="pageSize" value="5"/>--%>
        <%--        <c:forEach begin="1" end="${pageSize}" let="i">--%>
        <%--            <button onClick=pageChange(${i})>第${i}页</button>--%>
        <%--        </c:forEach>--%>
        <form onchange="formChange()" id="pageForm" method="get">
            <a href="">返回搜索</a>
            <a href="javascript:document.getElementById('page').value = 1;document.getElementById('pageForm').submit();">首页</a>
            <a href="javascript:document.getElementById('page').value = {maxPage};document.getElementById('pageForm').submit();">尾页</a>
            每页显示
            <label for="limit"></label><select name="limit" id="limit">
            <%
                for (int i = 1; i <= 5; i++) {
            %>
            <option <%=i == limit ? "selected" : ""%> value=<%=i%>>
                <%=i%>
            </option>
            <%
                }
            %>
        </select>
            条
            第
            <select name="page" id="page">
                <%
                    for (int i = 1; i <= maxPage; i++) {
                %>
                <option <%=i == pagi ? "selected" : ""%> value=<%=i%>>
                    <%=i%>
                </option>
                <%
                    }
                %>
            </select>
            页
            <button onclick="prevPage()" <%=page%> <= 1 ? "disabled" : ""%>>上一页</button>
            <button onclick="nextPage()" <%=page%> = maxPage ? "disabled" : ""%>>下一页</button>
        </form>

    </div>

    <script>
        let formChange = (e) => {
            let form = document.getElementById("pageForm");
            form.submit();
        }
        let nextPage = (e) => {
            let value = parseInt(document.getElementById("page").value);
            value >= <%=maxPage%> ? '' : document.getElementById("page").value = value + 1;
        }
        let prevPage = (e) => {
            let value = parseInt(document.getElementById("page").value);
            value === 1 ? '' : document.getElementById("page").value = value - 1;
        }
    </script>
</div>
</body>
</html>
