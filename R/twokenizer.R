#' POS tag tweets
#'
#' POS tag tweets in R, returning a dataframe with the columns of word, tag, and confidence.
#'
#' @param tagger_location The location of the "ark-tweet-nlp-0.3.2" folder.
#' @param text Tweet to be tagged.
#' @param model_location The location of an optional model to be used (e.g. Penn Treebank-style POS tags), instead of the standard model.
#'
#' @export
#'
#' @examples
#' #twokenizer("~/ark-tweet-nlp-0.3.2",
#' #"ikr smh he asked fir yo last name so he can add u on fb lololol")
twokenizer <- function(tagger_location, text, model_location = NULL){
  wd <- getwd()
  setwd(tagger_location)

  utils::write.table(text, "temp.txt",
              sep="\t",
              row.names = F,
              col.names = F,
              quote = F)

  if(missing(model_location)){
    data <- paste("./runTagger.sh --output-format conll", "temp.txt")
    tagged <- utils::read.table(text = system(data, intern = T),
                         sep = "\t",
                         quote = "",
                         fill = T)
  }
  else {
    data <- paste("./runTagger.sh --output-format conll ",
                  "--model ",
                  model_location,
                  " ", "temp.txt",
                  sep = "")

    tagged <- utils::read.table(text = system(data, intern = T),
                         sep = "\t",
                         quote = "",
                         fill = T)
  }

  tagged <- as.data.frame(tagged)
  colnames(tagged) <- c("word", "tag", "confidence")
  setwd(wd)
  tagged
}
