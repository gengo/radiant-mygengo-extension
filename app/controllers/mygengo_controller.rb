class MygengoController < ApplicationController

  helper :mugen

  protected

  def parse_errrors  
    unless Mugen.errors.empty?
      if flash[:error]
        flash[:error] << Mugen.errors.join(' | ')
      else
        flash[:error] = Mugen.errors.join(' | ')
      end
      Mugen.errors.clear
    end
  end
  
  def mygengo_requests
    yield
    parse_errrors
  end
        
end  