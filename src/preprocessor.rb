require 'asciidoctor'
require 'asciidoctor/extensions'

require 'asciidoctor/extensions'

Asciidoctor::Extensions.register do
  preprocessor do
    process do |document, reader|
      new_lines = []
      reader.readlines.each do |line|
        if line.strip == "[source,mermaid]"
          new_lines << "[mermaid]"
        else
          new_lines << line
        end
      end
      Asciidoctor::Reader.new(new_lines)
    end
  end
end
