#' Save an xlsx file with logging tables
#' @importFrom openxlsx createWorkbook addWorksheet writeData saveWorkbook
#' @export
#' @param logging_project A logging object from the `use_logging()` function
#' @examples
#' start_logging(project = "my logging project",
#'                         log_file = "my_project_log.xlsx",
#'                         yaml_file = "my_log.yaml")
#' logging_project <- use_logging("my_log.yaml")
#' x <- data.frame(this = "foo", that = "bar")
#' logging_project <- add_log_table(logging_project, "1", x)
#' save_logging(logging_project)
save_logging <- function(logging_project) {

  wb <- openxlsx::createWorkbook()

  project <- data.frame(Project = logging_project$project,
                        Updated = Sys.time())

  openxlsx::addWorksheet(wb, "README")
  openxlsx::writeData(wb, "README", project)

  sheets <- data.frame()

  for(i in seq_along(logging_project$logs)) {
    # i <- 1

    if("table" %in% names(logging_project$logs[[i]])) {
      sheets <- rbind(sheets,
                      data.frame(Worksheet = logging_project$logs[[i]]$name,
                                 Description = logging_project$logs[[i]]$description))

      openxlsx::addWorksheet(wb, logging_project$logs[[i]]$name)

      openxlsx::writeData(wb, logging_project$logs[[i]]$name,
                          logging_project$logs[[i]]$table)
    }

  }

  openxlsx::writeData(wb, "README", sheets, startRow = nrow(project) + 4,
                      startCol = ncol(project) + 1)

  openxlsx::saveWorkbook(wb, file = logging_project$log_file, overwrite = TRUE)
}
