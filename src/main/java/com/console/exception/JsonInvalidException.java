package com.console.exception;

import java.util.List;

public class JsonInvalidException extends RuntimeException {
	    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
		private List<String> errorMessages;
        private String messgage;
	    public String getMessgage() {
			return messgage;
		}

		public void setMessgage(String messgage) {
			this.messgage = messgage;
		}

		public JsonInvalidException(List<String> errorMessages) {
	        this.errorMessages = errorMessages;
	    }
		public JsonInvalidException(String errorMessages) {
	        this.messgage = errorMessages;
	    }
	    public List<String> getErrorMessages() {
	        return errorMessages;
	    }

	    public void setErrorMessages(List<String> errorMessages) {
	        this.errorMessages = errorMessages;
	    }
	    
}
