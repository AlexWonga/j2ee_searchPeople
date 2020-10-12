import java.io.*;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.alibaba.excel.EasyExcel;


public class SearchServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            String keyword = request.getParameter("keyword");
            response.setContentType("text/html");
            response.setCharacterEncoding("utf8");
            PrintWriter writer = response.getWriter();
            File xlsx = new File("E:/searchPeople/web/WEB-INF/contact/people.xlsx");
            InputStream inputStream = new FileInputStream(xlsx);
            List<Person> personList = EasyExcel.read(inputStream)
                    .head(Person.class)
                    .sheet()
                    .headRowNumber(1)
                    .doReadSync();
            writer.println("<h1>find people</h1>");
            for (Person person : personList) {
                String ID = person.ID;
                String name = person.name;
                String tel = person.telephone;
                String QQ = person.QQ;
                String email = person.email;
                if (ID.contains(keyword) || name.contains(keyword) || tel.contains(keyword) || QQ.contains(keyword) || email.contains(keyword)) {
                    writer.println("<p>personal info ID:" + ID + " name:" + name + " telephone:" + tel + " QQ:" + QQ + " email:" + email + "</p>");
                }
            }


    }
}
