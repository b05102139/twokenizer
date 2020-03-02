#' Download tagger
#'
#' Download Ark-TweetNLP's POS tagger, and optionally, its other models.
#'
#' @param outputLoc Location to put the tagger.
#' @param type What model to download. "base" must be downloaded first before the other two (i.e. "penn" and "irc") can be downloaded. The Penn model uses Penn Treebank-style tags, which may facilitate working with other packages, whereas the irc model is, as the ArkTweetNLP website states, "a model trained on the NPSChat IRC corpus, with a PTB-style tagset".
#'
#' @export
#'
#' @examples
#' #download_twokenizer("~/Documents", "base")
#'
#' #MUST DOWNLOAD "base" FIRST:
#' #download_twokenizer("~/Documents", "penn")
#' #download_twokenizer("~/Documents", "irc")
download_twokenizer <- function(outputLoc, type = c("base", "penn", "irc")){
  coreFile <- "/ark-tweet-nlp"
  type = match.arg(type)

  if (type == "base") {
    ret <- utils::download.file("https://github.com/brendano/ark-tweet-nlp/archive/master.zip",
                         destfile = paste0(outputLoc, coreFile, ".zip"))
    if (ret != 0)
      stop("Download error!")
    utils::unzip(paste0(outputLoc, coreFile, ".zip"), exdir = outputLoc)
    file.remove(paste0(outputLoc, coreFile, ".zip"))
    return(0L)
  }
  if (!file.exists(paste0(outputLoc, "/", coreFile)))
    stop("Must download base files to this location first! Set type='base'.")

  if (type == "penn") {
    utils::download.file("http://www.cs.cmu.edu/~ark/TweetNLP/model.ritter_ptb_alldata_fixed.20130723",
                  destfile = paste0(outputLoc, coreFile, "/penn_model"))
  }
  if (type == "irc") {
    utils::download.file("http://www.cs.cmu.edu/~ark/TweetNLP/model.irc.20121211",
                  destfile = paste0(outputLoc, coreFile, "/irc_model"))
  }
}
