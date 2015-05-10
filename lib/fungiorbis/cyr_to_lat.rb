module Fungiorbis
  class CyrToLat

    CYR = %w(А а Б б В в Г г Д д Ђ ђ Е е Ж ж З з И и Ј ј К к Л л Љ љ М м Н н Њ њ О о П п Р р С с Т т Ћ ћ У у Ф ф Х х Ц ц Ч ч Џ џ Ш ш)
    LAT = %w(A a B b V v G g D d Đ đ E e Ž ž Z z I i J j K k L l Lj lj M m N n Nj nj O o P p R r S s T t Ć ć U u F f H h C c Č č Dž dž Š š)

    class << self
      def transliterate(string)
        return '' if string.nil?
        str = string.dup
        CYR.each_with_index do |letter, index|
          str.gsub! letter, LAT[index] if string.respond_to?(:gsub!)
        end
        str
      end
    end
  end
end