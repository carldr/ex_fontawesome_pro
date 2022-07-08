defmodule Mix.Tasks.ExFontawesomePro do
  use Mix.Task

  @shortdoc "Downloads the FontAwesome Pro icons, assuming a valid token in the environment."
  def run(_) do
    File.cd( System.get_env( "EX_FONTAWESOME_PRO" ) )
    System.cmd( "npm", [ "install" ] )
  end
end
