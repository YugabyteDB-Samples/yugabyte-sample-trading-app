
provider "aws" {
  region = "us-east-2"
  alias  = "Boston"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "us-east-2"
  alias  = "Ohio"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "us-east-1"
  alias  = "N_Virginia"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "Washington"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "us-west-1"
  alias  = "N_California"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "us-west-2"
  alias  = "Oregon"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "af-south-1"
  alias  = "Cape_Town"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "ap-east-1"
  alias  = "Hong_Kong"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "ap-southeast-3"
  alias  = "Jakarta"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "ap-south-1"
  alias  = "Mumbai"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "ap-northeast-3"
  alias  = "Osaka"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "ap-northeast-2"
  alias  = "Seoul"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "ap-southeast-1"
  alias  = "Singapore"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "ap-southeast-2"
  alias  = "Sydney"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "ap-northeast-1"
  alias  = "Tokyo"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "ca-central-1"
  alias  = "Canada"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "eu-central-1"
  alias  = "Frankfurt"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "eu-west-1"
  alias  = "Ireland"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "eu-west-2"
  alias  = "London"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "eu-south-1"
  alias  = "Milan"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "eu-west-3"
  alias  = "Paris"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "eu-north-1"
  alias  = "Stockholm"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "me-south-1"
  alias  = "Bahrain"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "me-central-1"
  alias  = "UAE"
  default_tags {
    tags = local.tags
  }
}
provider "aws" {
  region = "sa-east-1"
  alias  = "Sao_Paulo"
  default_tags {
    tags = local.tags
  }
}
