//
//import CoreData
//
//// data generator handles:
//// 1: Preparing the system for new Thoughts Scene delegate launch.
//class DataGenerator: NSObject {
//
//    var context: NSManagedObjectContext? = PersistantContainer.store?.viewContext
//
//    func generateTestData() {
//        guard let context = context else { return }
//        var configurator: ThoughtConfigurator? = ThoughtConfigurator()
//        configurator?.delegate = self
//
//        var thoughts = [Thought]()
//        let contentStrings: [String] = self.contents + self.testingContent
//
//        for title in contentStrings {
//
//            let thought = Thought.insert(in: context, content: title)
//            self.content = title
//            configurator?.generate { (kws) in kws.addThought(thought) }
//            thoughts.append(thought)
//            self.content = ""
//
//            // release and reset configurator on every iteration.  Not sure why but keywords cascade into following thoughts in loop, this is the quick fix sorry future Gifton
//            configurator = nil
//            configurator = ThoughtConfigurator()
//            configurator?.delegate = self
//
//        }
//
//        let _ = ThoughtSequence.insert(into: context, withRelationships: thoughts, title: "Welcome Sequence")
//
//        _ = context.saveOrRollback()
//    }
//
//
//    func updateShared() {
//
//        guard let context = context else { return }
//
//        let request = Keyword.sortedFetchRequest
//        request.shouldRefreshRefetchedObjects = true
//        request.returnsObjectsAsFaults = false
//
//        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
//        request.sortDescriptors = [sortDescriptor]
//
//        do {
//
//            let out = try context.fetch(request)
//            if (ThoughtConfigurator.shared.getExtsitingKeywords().isEmpty) {
//                ThoughtConfigurator.shared.configure(addKeywords: out)
//            }
//
//            if out.isEmpty {
//                generateTestData()
//            }
//
//
//
//        } catch { print("unable to get keywords") }
//
//    }
//
//    var content: String = ""
//    var mapper = EmojiMap()
//}
//extension DataGenerator: ThoughtConfiguratorDelegate {
//
//    func createNewKeyword(fromTitle title: String) -> Keyword? {
//
//        let emoji = mapper.getSingleRandomMatchesFor(title)
//
//        guard let context = context else { return nil }
//        let kw = Keyword.insert(into: context, withEmoji: emoji.first?.emoji ?? "☁️", andTitle: title)
//        return kw
//
//    }
//
//    func addExistingKeyword(_ keyword: Keyword) {}
//}
//
//
//private extension DataGenerator {
//
//    var contents: [String] {
//        return [
//            "Welcome to YOU! Here you will be able to save your thoughts in an intuitive and accessable way.  Thoughts are the main building blocks of YOU. They solidify ideas and concepts, and prepare them for relation to one another.",
//            "Once a Thought has been created, YOU will identify keywords in your thought, and share it with you.  You'll be able to look through those Keywords and find trails of other Thoughts that have similar concepts in them.",
//            "Sequences Help you organize your Thoughts into lists with an overarching Theme. Use sequences to group together Thoughts, or to help continue your train of Thought",
//            "The Explore page is where you'll find every Thought, Sequence and Keyword you've cerated, sort, search and filter your heart out!",
//            "The progress page lets you look at all your interactions with YOU.  Its important to recognize effort, and the progress page is dedicated to that.  If you're having trouble finding a Thought you know you had seen recently, take a look at the Progress page you might find it there!",
//            "Thank you so much for being a part of the beta for YOU! The support is immensly appreciated, and I hope you find YOU to be as useful as I certainly do",
//        ]
//    }
//
//    var randomDate: Date {
//
//        return Date(timeIntervalSinceNow: Double(arc4random_uniform(UInt32(100))))
//
//    }
//
//}
//
//
//
//private extension DataGenerator {
//    var testingContent: [String] {
//        return [
//            "Factual: YOU is an application that allows its user to record any sort of text.  Ideally its used as a short-form journal of sorts, jotting and recording thoughts into it.  YOU will take those Thoughts and identify Keywords that appear within the thought.  Keywords don’t have to be identical words to what's recorded, but correlated words.  For example a thought that contains the word 'guitar' should also belong to the keyword 'Music'.  YOU takes those keywords and builds relationships between your thoughts, and gives them a weight based on their keywords. A major feature of YOU is the Sequences;  They let you group thoughts together under a single general (multi word) identity title.  Putting thoughts together increases the relationships between their keywords, and in turn allows for a more accurate initiation of relationship weights. Progress within self improvement is difficult to quantify and identify, for now YOU will show you the things you’ve been working on - thinking on.  Any edit, view or creation will be recorded and reflected on the progress page.  Likewise thoughts keep a close tally on all the changes made to it.  Displaying edits and views of the thought within its page. ",
//            "YOU Journaling is a concept and system that can be investigated through a few unique lenses, we'll walk through each one and solidify our general understanding of the application",
//            "Philosophically: There's a quote that states 'inspiration strikes at the point of correlation between two seemingly unrelated concepts'.  Historically these points of inspiration have been linked to some of the biggest revolutions in the propagation of our species.  If we look at the physical world as a seemingly endless operation of randominity, we attempt to improve our chances of this 'inspiration' striking by building systems that can find these correlations outside of your brain.  Whether it’s the improvement of communication, replication of physical concepts through fabricated structures like Mathematics and Physics, or through the expression of Art, even through the desire to create intelligence similar to our own. We have long built things from our mind.  We soon need to think inward, and build tools that allow us to no longer rely on spontaneity to provide a breakthrough, or to apply methods to seemingly unrelated systems.  Doing so would ideally allow for a human to build an intuition for their ability to create these spikes of inspiration, and hopefully improve their ability to progress through a thought. And in turn improve society.",
//            "Technical: When we speak on the technical aspects of YOU, we'll speak on its current implementation, and execution.  YOU takes thoughts that are inputted into it, and using Apples Natural Language framework, along with the TextRank algorithm, identifies all the keywords within a thought.  When we want to find related thoughts we essentially boil down a thought to its keywords, and build a relationship map between the two thoughts' keywords, defining its weight as: Let Textranks output = w1, let the number of abstract canonical layers apples natural langue has to explore to find the relationship",
//            "Cognitively: Essentially we want to build a system that compliments the cognitive processes we execute daily.  The foremost concept is the application of proper weight to our everyday thoughts.  We have as a species an average of thoughts 60,000 thoughts a day, with less than 5% of them being unique, non-repetitive thoughts.  Realistically giving weight to these thoughts is impossible.  Its fairly easy to filter out about 80% of the thoughts we don’t want with an application like YOU.  Any thought not worth saving would ideally not be recorded.  We must keep in mind that there are thoughts that belong inside of YOU that never make it, and in an ideal world we wouldn’t worry about this.  Similarly we may have a small percentage of thoughts that don’t belong in YOU, this is an opportunity for YOU to learn more about our thought patterns.  Identifying the most important thoughts will be difficult, and to be fully transparent Im not sure how it should be done, but realistically, I think that we will want to catagorize the thoughts we have within some sort of hyperplane, or graph, and discriminate against thoughts that have either a) strong connections to other thoughts (or concepts), as well as the number of vertices a thought has. Building a map of these thoughts, there relationships, and those relationship maps, I believe we may be able to graphically represent peoples thought processes, and more importantly give light to the geniune weight of a thought.  But whats important is our lack of cognitive ability to compare those new found (or not) concepts and ideas and apply them to EVERY thought we've had.  We can increase the probability of inspiration if we do that. ",
//            "BCI & Neuralance: In respect to the issue we spoke on in the cognitive section about the loss of data between the brain and YOU, lowering the barrier for entry of thoughts will be essential to building realistic graphical representations of our thoughts, we may be able to plan for the future that includes applicable hardware like Neuralinks Brain-Computer-Interface.  Being able to automatically and unintelligibly record those thoughts may be a future that brings many discoveries.",
//            "Medically An application like this could be incredibly useful for practitioners working with patience to improve their mental state, without having to reveal incredibly personal information the application could learn the habits and attitudes of the user and report to a medical professional to give them genuine and useful information towards the assessment of a patient. Giving people with disabilities the ability to take advantage of this system will be a great benefit as well, in terms of therapy, as well as long term studies of the effects of these disabilities. Another connsideration is the use of machine learning to detect early signs of different mental ilnesses, based on the inputs, as well as how they input the information. ",
//            "Current Approaches: There have been / are a few attempts at building similar systems.  However the biggest challenge for those systems is how to get the most useful data.  Data from social networks or instant messengers is unfortunately tainted, and don’t properly derive the users state.  Communication always requires a level of filtration, or compilation for proper propagation. YOU is an attempt to gather the correct kind of data, what people genuinely think, and use that as a basis for our research. YOU is the perfect application because it immediately filters out the people who are least likely to have these spikes of inspiration.  The percentage of people that journal is not high, but the percentage of successful people who  Pairing the idea of improving your own cognitive ability with a platform whom can benefit from that progress as well is a win win system",
//
//        ]
//    }
//}
