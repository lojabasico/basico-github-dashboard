
class ChartData
    include Virtus::Model

    attribute :labels,    Array[String]
    attribute :series,    Array[Integer]

end
