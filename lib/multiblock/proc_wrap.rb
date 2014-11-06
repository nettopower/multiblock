class Proc
  def wrap
    @wrap ||= Multiblock.wrap(&self)
  end
end