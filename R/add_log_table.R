#' Add a data.frame to a logging project
#'
#' @export
#' @param logging_project A logging object from the `use_logging()` function
#' @param log_id The id value in the yaml file
#' @param log_table A data.frame to be logged
#' @examples
#' start_logging(project = "my logging project",
#'                         log_file = "my_project_log.xlsx",
#'                         yaml_file = "my_log.yaml")
#' logging_project <- use_logging("my_log.yaml")
#' x <- data.frame(this = "foo", that = "bar")
#' logging_project <- add_log_table(logging_project, "1", x)
add_log_table <- function(logging_project, log_id, log_table) {

  log_ids <- unlist(lapply(logging_project$logs, function(x) x[["id"]]))

  if(!log_id %in% log_ids) {
    stop(paste(log_id, "not an id in the logging yaml file"))
  }

  for(i in seq_along(logging_project$logs)) {
    if(logging_project$logs[[i]]$id == log_id) {
      logging_project$logs[[i]]$table <- log_table
    }
  }

  logging_project
}
