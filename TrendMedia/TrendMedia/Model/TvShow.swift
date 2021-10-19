//
//  TvShow.swift
//  TrendMedia
//
//  Created by meng on 2021/10/19.
//


struct TvShow {
    
  var title: String
  var releaseDate: String
  var genre: String
  var region: String
  var overview: String
  var rate: Float
  var starring: String
  var backdropImage: String
}


final class DataManager {
    static let tvShow: [TvShow] = [
        TvShow(title: "Squid Game", releaseDate: "09/17/2021",genre: "Mystery",region: "South Korea", overview: "Hundreds of cash-strapped players accept a strange invitation to compete in children's games. Inside, a tempting prize awaits — with deadly high stakes.", rate: 8.3, starring: "Lee Jung-jae, Park Hae-soo, Wi Ha-jun, Heo Sung-tae, Kim Joo-ryoung, Jung Ho-yeon, Lee You-mi",backdropImage:"https://www.themoviedb.org/t/p/original/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg"),
        
        TvShow(title: "Maid", releaseDate: "10/01/2021",genre: "Drama",region:"United States", overview: "After fleeing an abusive relationship, a young mother finds a job cleaning houses and fights to provide a better future for her child.", rate: 8.6, starring:"Margaret Qualley, Nick Robinson, Anika Noni Rose, Andie MacDowell, Tracy Vilar, Billy Burke, Rylea Nevaeh Whittet",backdropImage:"https://www.themoviedb.org/t/p/original/u4ydZotyPdOxSGAVUBiQnKLVwmz.jpg"),
        
        TvShow(title: "The Five Juanas", releaseDate: "10/06/2021",genre: "Drama",region:"Mexico", overview: "Five women with the same birthmark set out to unravel the truth about their pasts and discover a tragic web of lies spun by a powerful politician.", rate: 7.0, starring:"Sofia Engberg, White Vega, Renata Notni, Juanita Arias, Oka Giner",backdropImage:"https://www.themoviedb.org/t/p/original/jB27sNxsgITNhr6HavrHywojy8V.jpg"),
        
        
        TvShow(title: "Sex Education", releaseDate: "01/11/2019",genre: "Comedy",region:"United States", overview: "Inexperienced Otis channels his sex therapist mom when he teams up with rebellious Maeve to set up an underground sex therapy clinic at school.", rate: 8.6, starring:"Asa Butterfield, Gillian Anderson, Ncuti Gatwa, Emma Mackey, Kedar Williams-Stirling, Aimée-Lou Wood, Connor Swindells",backdropImage:"https://www.themoviedb.org/t/p/original/1c7zy6zUbZ2s4zFAy6CpKipQvdQ.jpg"),
        
        
        TvShow(title: "Alice in Borderland", releaseDate: "12/10/2020",genre: "Mystery",region:"Japen", overview: "With his two friends, a video-game-obsessed young man finds himself in a strange version of Tokyo where they must compete in dangerous games to win.", rate: 7.9, starring:"Kento Yamazaki, Tao Tsuchiya, Nijiro Murakami, Yuki Morinaga, Keita Machida, Ayame Misaki",backdropImage:"https://www.themoviedb.org/t/p/original/bKxiLRPVWe2nZXCzt6JPr5HNWYm.jpg"),
        
        
        TvShow(title: "Kastanjemanden", releaseDate: "09/29/2021",genre: "Crime",region:"Denmark", overview: "At a grisly murder scene sits a figurine made of chestnuts. From this creepy clue, two detectives hunt a killer linked to a politician's missing child.", rate: 8.3, starring: "Danica Ćurčić, Mikkel Boe Folsgaard, David Dencik, Iben Dorner, Lars Ranthe, Signe Egholm Olsen, Esben Dalgaard Andersen",backdropImage:"https://www.themoviedb.org/t/p/original/fIXTetAsXkPO6UUUw85IU4oactf.jpg"),
        
        
        TvShow(title: "Hometown Cha-Cha-Cha", releaseDate: "08/28/2021",genre: "Crime",region:"South Korea", overview: "A big-city dentist opens up a practice in a close-knit seaside village, home to a charming jack-of-all-trades who is her polar opposite in every way.", rate: 9.0, starring: "Shin Min-a, Kim Seon-ho, Lee Sang-yi, Lee Suk-hyeong, Jo Han-chul, In Gyo-jin, Lee Bong-ryeon",backdropImage:"https://www.themoviedb.org/t/p/original/ffYmWMifWThFgDI7DkFBRc1SC1b.jpg"),
        
        
        TvShow(title: "Paw Patrol", releaseDate: "08/12/2013",genre: "Animation",region:"United States", overview: "A group of six rescue dogs, led by a tech-savvy boy named Ryder, has adventures in PAW Patrol. The heroic pups, who believe no job is too big, no pup is too small, work together to protect the community. Among the members of the group are firedog Marshall, police pup Chase, and fearless Skye. All of the animals have special skills, gadgets and vehicles that help them on their rescue missions. Whether rescuing a kitten or saving a train from a rockslide, the PAW Patrol is always up for the challenge while also making sure there's time for a game or a laugh.", rate: 6.2, starring: "Jaxon Mercey, Drew Davis, Justin Kelly, Devan Cohen, Samuel Faraci, Carter Thorne, Kallan Holley",backdropImage:"https://www.themoviedb.org/t/p/original/a17F3zXnmuwqxfiDa46mtlosjrv.jpg"),
        
        
        TvShow(title: "The Baby-Sitters Club", releaseDate: "07/03/2020",genre: "Comedy",region:"United States", overview: "In this contemporary take on the beloved book series, five best friends launch a baby-sitting business that's big on fun and adventure.", rate: 6.2, starring: "Malia Baker, Shay Rudolph, Sophie Grace, Momona Tamada",backdropImage:"https://www.themoviedb.org/t/p/original/lhk5vgXN4Mnz4YWDw5RDqTaqPLd.jpg"),
        
        
        TvShow(title: "A Tale Dark & Grimm", releaseDate: "10/08/2021",genre: "Animation",region:"United States", overview: "Follow Hansel and Gretel as they walk out of their own story into a winding and wickedly witty tale full of strange — and scary — surprises.", rate: 6.2, starring: "",backdropImage:"https://www.themoviedb.org/t/p/original/luzRIdzL9RzfQoaIVyZW6CvMxY6.jpg"),
        
        
        TvShow(title: "Grey's Anatomy", releaseDate: "03/27/2005",genre: "Drama",region:"United States", overview: "Follows the personal and professional lives of a group of doctors at Seattle’s Grey Sloan Memorial Hospital.", rate: 7.6, starring: "Ellen Pompeo, Justin Chambers, James Pickens Jr., Chandra Wilson, Vanessa Bell Calloway",backdropImage:"https://www.themoviedb.org/t/p/original/6yUbsvFXLojGXlD86yz79toYywn.jpg"),
        
        TvShow(title: "House of Secrets: The Burari Deaths", releaseDate: "10/08/2021",genre: "Documentary",region:"India", overview: "Suicide, murder... or something else? This docuseries examines chilling truths and theories around the deaths of 11 members of a Delhi family.", rate: 0.0, starring: "",backdropImage:"https://www.themoviedb.org/t/p/original/fw3DUxlgGFAg8zarKJbQZ3xn25X.jpg"),
        
        
        TvShow(title: "The King's Affection", releaseDate: "10/11/2021",genre: "Drama",region:"South Korea", overview: "When the crown prince is killed, his twin sister assumes the throne while trying to keep her identity and affection for her first love a royal secret.", rate: 0.0, starring: "Park Eun-bin, Rowoon, Nam Yoon-su, Bae Yoon-kyung, Choi Byung-chan, Lee Pil-mo, Han Chae-ah",backdropImage:"https://www.themoviedb.org/t/p/original/4r7scgI5aUrShN0YzriAatWd15e.jpg"),
        
        
        TvShow(title: "Nevertheless", releaseDate: "06/19/2021",genre: "Drama",region:"South Korea", overview: "The intoxicating charm of a flirtatious art school classmate pulls a reluctant love cynic into a friends-with-benefits relationship.", rate: 0.0, starring: "Han So-hee, Song Kang, Chae Jong-hyeop, Lee Yeol-eum, Yang Hye-ji, Yoon Seo-A, Jeong Jae-kwang",backdropImage:"https://www.themoviedb.org/t/p/original/7tBqUyojEaOTTzRZBRaOgp2tWQG.jpg"),
        
        
        TvShow(title: "The Billion Dollar Code", releaseDate: "10/07/2021",genre: "Drama",region:"Germany", overview: "How stupid is the idea of ??messing with a global corporation? Two German computer nerds tried it out for you. Trillion dollar code, based on a true story, on Netflix October 7th.", rate: 8.0, starring: "Marius Ahrendt, Misel Maticevic, Seumas F. Sargent",backdropImage:"https://www.themoviedb.org/t/p/original/ddFwgyFvaiN5VvUhX0CJBOhlADQ.jpg"),
    ]
}
