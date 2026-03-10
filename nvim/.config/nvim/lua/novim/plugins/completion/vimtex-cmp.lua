return {
  "micangl/cmp-vimtex",
  config = function()
    require('cmp_vimtex').setup({
      additional_information = {
        info_in_menu = true,
        info_in_window = true,
        info_max_length = 60,
        match_against_info = true,
        symbols_in_menu = true,
      },
      bibtex_parser = {
        enabled = true,
      },
      search = {
        browser = "xdg-open",
        default = "google_scholar",
        search_engines = {
          google_scholar = {
            name = "Google Scholar",
            get_url = require('cmp_vimtex').url_default_format("https://scholar.google.com/scholar?hl=en&q=%s"),
          },
          arxiv = {
            name = "arXiv",
            get_url = require('cmp_vimtex').url_default_format("https://arxiv.org/search/?query=%s&searchtype=all&source=header"),
          },
          pubmed = {
            name = "PubMed",
            get_url = require('cmp_vimtex').url_default_format("https://pubmed.ncbi.nlm.nih.gov/?term=%s"),
          },
        },
      },
    })
  end,
}
