package org.zerock.config;

/**
 * Backend API base URL configuration.
 * Frontend controllers use this to call the backend REST API.
 */
public class BackendConfig {

	public static final String BACKEND_URL = System.getenv("BE_HOTEL_URL") != null
		? System.getenv("BE_HOTEL_URL")
		: "http://localhost:8082/api";

}
