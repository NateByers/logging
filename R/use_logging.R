#' Use a logging project
#'
#' @importFrom yaml read_yaml
#' @param  yaml_file The full path of the .yaml file for the logging project
#' @export
use_logging <- function(yaml_file) {
  # yaml_file <- "//chp.clarian.org/group/MH/MH System Clinical Services/Virtual Visits Implementation/Telehealth Director's Folder/COVID-19/QA/HR Data Reporting/log.yaml"

  project <- yaml::read_yaml(yaml_file)


  project
}
