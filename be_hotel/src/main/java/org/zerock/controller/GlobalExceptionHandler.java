package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(MethodArgumentNotValidException.class)
	public ResponseEntity<Map<String, Object>> handleValidationException(MethodArgumentNotValidException ex) {
		log.warn("Validation failed: {}", ex.getMessage());

		List<Map<String, String>> errors = ex.getBindingResult()
				.getFieldErrors()
				.stream()
				.map(error -> {
					Map<String, String> errorMap = new HashMap<>();
					errorMap.put("field", error.getField());
					errorMap.put("message", error.getDefaultMessage());
					return errorMap;
				})
				.collect(Collectors.toList());

		Map<String, Object> response = new HashMap<>();
		response.put("success", false);
		response.put("errors", errors);

		return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
	}

	@ExceptionHandler(HttpMessageNotReadableException.class)
	public ResponseEntity<Map<String, Object>> handleMalformedJson(HttpMessageNotReadableException ex) {
		log.warn("Malformed JSON: {}", ex.getMessage());

		Map<String, Object> response = new HashMap<>();
		response.put("success", false);
		response.put("errors", List.of(
				Map.of("field", "requestBody", "message", "요청 본문을 파싱할 수 없습니다")));

		return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
	}

	@ExceptionHandler(DuplicateKeyException.class)
	public ResponseEntity<Map<String, Object>> handleDuplicateKey(DuplicateKeyException ex) {
		log.warn("Duplicate key: {}", ex.getMessage());

		Map<String, Object> response = new HashMap<>();
		response.put("success", false);
		response.put("errors", List.of(
				Map.of("field", "duplicate", "message", "이미 등록된 데이터입니다")));

		return new ResponseEntity<>(response, HttpStatus.CONFLICT);
	}

	@ExceptionHandler(Exception.class)
	public ResponseEntity<Map<String, Object>> handleGeneral(Exception ex) {
		log.error("Unhandled exception: ", ex);

		Map<String, Object> response = new HashMap<>();
		response.put("success", false);
		response.put("errors", List.of(
				Map.of("field", "server", "message", ex.getMessage() != null ? ex.getMessage() : "서버 오류가 발생했습니다")));

		return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
