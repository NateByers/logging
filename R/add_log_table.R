#' Add a data.frame to a logging project
#'
#' @importFrom readxl read_excel
#' @importFrom dplyr %>% mutate mutate_at full_join
#' @importFrom tidyr replace_na
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
  # logging_project <- use_logging("//chp.clarian.org/group/MH/MH System Clinical Services/Virtual Visits Implementation/Telehealth Director's Folder/COVID-19/QA/HR Data Reporting/log.yaml")
  # log_id <- "1"
  # log_table <- data.frame(employee_id = c(1, 13605, 13605),
  #                         quarantine_date = as.Date(c("2020-04-13", "2020-3-29",
  #                                                     "2020-4-11")))


  log_ids <- unlist(lapply(logging_project$logs, function(x) x[["id"]]))

  if(!log_id %in% log_ids) {
    stop(paste(log_id, "not an id in the logging yaml file"))
  }

  for(i in seq_along(logging_project$logs)) {
    # i <- 1

    if("corrected_column" %in% names(logging_project$logs[[i]])) {

      if(file.exists(logging_project$log_file)) {

        log_table_ <- readxl::read_excel(logging_project$log_file,
                                         logging_project$logs[[i]]$name) %>%
          dplyr::mutate_at(logging_project$logs[[i]]$corrected_column, toupper) %>%
          dplyr::mutate_all(as.character)

        join_columns <- names(log_table)[names(log_table) %in% names(log_table_)]

        corrected_column_list <- list()
        corrected_column_list[[logging_project$logs[[i]]$corrected_column]] <- "FALSE"

        log_table <- log_table %>%
          dplyr::ungroup() %>%
          dplyr::mutate_all(as.character) %>%
          dplyr::full_join(log_table_, join_columns) %>%
          tidyr::replace_na(corrected_column_list)

      }

    }

    logging_project$logs[[i]]$table <- log_table

  }

  logging_project
}
