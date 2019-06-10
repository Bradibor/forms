package ru.mirea.forms;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

import javax.xml.transform.TransformerException;
import java.io.FileNotFoundException;
import java.io.IOException;

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
