package ru.miref.forms;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.NoHandlerFoundException;

import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Optional;

@SpringBootApplication
@Controller
@Slf4j
public class FormsApplication {

    public static void main(String[] args) {
        SpringApplication.run(FormsApplication.class, args);
    }

    private String formsPath;
    private Transformer transformer;

    /**
     * При инициализации класса сразу проверяются все необходимые для работы переменные из файла конфигурации
     * В случае неудачной инициализации веб-сервис не запустится и выведет ошибку в лог
     *
     * @param environment окружение для получения параметров конфигурации
     * @throws TransformerConfigurationException ошибка при создании объекта преобразования на основе xslt-шаблона
     */
    public FormsApplication(Environment environment) throws TransformerConfigurationException {
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

    /**
     * Перехватывает ошибки которые могут возникнуть при работе веб-сервиса
     * Методы возвращают более понятные (чем стандартный обработчик ошибок) сообщения пользователю
     */
    @ControllerAdvice
    public class CustomExceptionHandler {
        @ExceptionHandler(IOException.class)
        public ResponseEntity handleIOException(FileNotFoundException e) {
            return new ResponseEntity<>("Файл отчетной формы не найден: ", HttpStatus.NOT_FOUND);
        }

        @ExceptionHandler(TransformerException.class)
        public ResponseEntity handleXslException(TransformerException e) {
            return new ResponseEntity<>("Ошибка преобразования: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
        public ResponseEntity hanleMethodException(HttpRequestMethodNotSupportedException e) {
            return new ResponseEntity<>("Метод запроса " + e.getMethod() + " не поддерживается, используейте GET", HttpStatus.METHOD_NOT_ALLOWED);
        }

        @ExceptionHandler(NoHandlerFoundException.class)
        public ResponseEntity handleNotFoundException(NoHandlerFoundException e) {
            return new ResponseEntity<>("Адрес " + e.getRequestURL() + " не поддерживается, используйте /forms/*", HttpStatus.NOT_FOUND);
        }
    }
}
