String formatEmailSuggestion(String value) {
  // Conservative helper: return the trimmed value only.
  // Reason: previously this utility appended '@gmail.com' when the
  // user typed only a local part. That behavior could cause invalid
  // emails like 'user@gmail.com@gmail.com' if used during form
  // autofill or suggestion. Keep this function safe and side-effect free.
  return value.trim();
}
