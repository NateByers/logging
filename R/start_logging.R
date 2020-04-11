#' Create a log yaml file
#'
#' @param project The name of the project
#' @param log_file The full path of where the .xlsx Excel log file will be
#' @param yaml_file The full path of where the .yaml file will be
#' @importFrom yaml write_yaml
#' @export
#'
start_logging <- function(project, log_file, yaml_file) {
  # log_file <- "//chp.clarian.org/group/MH/MH System Clinical Services/Virtual Visits Implementation/Telehealth Director's Folder/COVID-19/QA/HR Data Reporting/log.xlsx"; yaml_file <- "//chp.clarian.org/group/MH/MH System Clinical Services/Virtual Visits Implementation/Telehealth Director's Folder/COVID-19/QA/HR Data Reporting/log.yaml"; project = "HR_quarantine"

  log_list <- list(project = project,
                   log_file = log_file,
                   logs = list(
                     list(
                       id = "1",
                       name = "log 2",
                       description = "short description"
                     ),
                     list(
                       id = "2",
                       name = "log 2",
                       description = "short description"
                     )
                     )
                   )

  yaml::write_yaml(log_list, file = yaml_file)
}
