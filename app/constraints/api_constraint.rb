class ApiConstraint
  attr_reader :version
 
  def initialize(options)
    @version = options.fetch(:version)
  end
 
  def matches?(request)  
    accept_header = request.headers.fetch(:accept)
    return accept_header.include?("version=#{version}") ||
      accept_header !~ /version=[0-9]*/
  end
end