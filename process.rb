file = File.open('dict.txt')

lookup = {}
while (word = file.gets)
  unless word.nil?
    word.chomp!.downcase!
  end
  if word.length == 1
    next
  end
  sorted_word = word.split(//).sort.join
  if lookup.has_key?(sorted_word)
    lookup[sorted_word] << word
  else
    lookup[sorted_word] = [word]
  end
end

File.open('dictionary_processed','wb') do |f|
  f.write Marshal.dump(lookup)
end
file.close
