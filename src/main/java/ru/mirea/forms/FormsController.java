package ru.mirea.forms;

import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Optional;

@Controller
public class FormsController {
    private String formsPath;
    private Transformer transformer;

    /**
     * При инициализации класса сразу проверяются все необходимые для работы переменные из файла конфигурации
     * В случае неудачной инициализации веб-сервис не запустится и выведет ошибку в лог
     *
     * @param environment окружение для получения параметров конфигурации
     * @throws TransformerConfigurationException ошибка при создании объекта преобразования на основе xslt-шаблона
     */
    public FormsController(Environment environment) throws TransformerConfigurationException {
        formsPath = Optional.ofNullable(environment.getProperty("path.forms"))
                .orElseThrow(() -> new IllegalArgumentException("No property path.form specified!"));
        String xslPath = Optional.ofNullable(environment.getProperty("path.xsl"))
                .orElseThrow(() -> new IllegalArgumentException("No property path.xsl specified!"));
        StreamSource xslSource = new StreamSource(Paths.get(xslPath).toFile());
        transformer = TransformerFactory.newInstance().newTransformer(xslSource);
    }

    /**
     * Обработка запроса на получение преобразованной в html отчетноый формы
     * При обработке назвения файла отчетной формы отсекается часть расширения в случае если оно есть
     * Например, при вызове "form.html" будет все равно произведен поиск "form.xml"
     *
     * @param name имя файла отчетной формы
     * @param response объект http-ответа в который будет записана преобразованная в html отчетная формы
     * @throws TransformerException ошибка при преобразовании отчетной формы
     * @throws IOException ошибка получения файла отчетной формы
     */
    @GetMapping("/forms/{name}")
    public @ResponseBody
    void getForm(@PathVariable("name") String name, HttpServletResponse response) throws TransformerException, IOException {
        name = name.lastIndexOf(".") < 0 ? name : name.substring(0, name.lastIndexOf("."));
        StreamSource dataSource = new StreamSource(new FileInputStream(Paths.get(formsPath, name + ".xml").toFile()));
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        Result result = new StreamResult(out);
        transformer.transform(dataSource, result);
        response.getOutputStream().write(out.toByteArray());
    }
}
