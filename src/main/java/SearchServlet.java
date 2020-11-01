import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.alibaba.excel.EasyExcel;
import pojo.Person;


public class SearchServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String keyword = request.getParameter("keyword");
        if(Objects.isNull(keyword)){
            keyword = (String) session.getAttribute("keyword");
        }else {
            session.setAttribute("keyword",keyword);
        }

        Integer page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
        Integer limit = Integer.parseInt(request.getParameter("limit") != null ? request.getParameter("limit") : "5");
        File xlsx = new File("E:/j2ee_searchPeople1/web/WEB-INF/contact/people.xlsx");
        InputStream inputStream = new FileInputStream(xlsx);
        List<Person> personList = EasyExcel.read(inputStream)
                .head(Person.class)
                .sheet()
                .headRowNumber(1)
                .doReadSync();
        List<Person> result = new ArrayList<>();
        for (Person person : personList) {
            String ID = person.getId();
            String name = person.getName();
            String tel = person.getTelephone();
            String QQ = person.getQq();
            String email = person.getEmail();
            System.out.println(ID + name + tel + QQ + email);
            if (Objects.isNull(ID) || Objects.isNull(name) || Objects.isNull(tel) || Objects.isNull(QQ) || Objects.isNull(email)) {
                continue;
            }
            if (ID.contains(keyword) || name.contains(keyword) || tel.contains(keyword) || QQ.contains(keyword) || email.contains(keyword)) {
                result.add(person);
            }
        }
        request.setAttribute("personList", result);
        request.setAttribute("page", page);
        request.setAttribute("limit", limit);
        request.getRequestDispatcher("/show.jsp").forward(request, response);
    }
}
