import 'package:flutter/material.dart';

void main() {
  runApp(const CineprabuApp());
}

class CineprabuApp extends StatelessWidget {
  const CineprabuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cineprabu',
      theme: ThemeData(
        primaryColor: const Color(0xFF1A1A2E),
        scaffoldBackgroundColor: const Color(0xFF0F0F1E),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF00D9FF),
          secondary: const Color(0xFFFF006E),
          surface: const Color(0xFF1A1A2E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A2E),
          elevation: 0,
        ),
      ),
      home: const MainNavigationPage(),
    );
  }
}

class Movie {
  final String title;
  final String genre;
  final String rating;
  final String duration;
  final String ageRating;
  final List<MovieSchedule> schedules;
  final String? imageUrl;

  Movie({
    required this.title,
    required this.genre,
    required this.rating,
    required this.duration,
    required this.ageRating,
    required this.schedules,
    this.imageUrl,
  });
}

class MovieSchedule {
  final String cinema;
  final int price;
  final String date;
  final List<String> showtimes;

  MovieSchedule({
    required this.cinema,
    required this.price,
    required this.date,
    required this.showtimes,
  });
}

class BookedTicket {
  final String movieTitle;
  final String cinema;
  final String date;
  final String time;
  final String seat;
  final int price;
  final String bookingId;

  BookedTicket({
    required this.movieTitle,
    required this.cinema,
    required this.date,
    required this.time,
    required this.seat,
    required this.price,
    required this.bookingId,
  });
}

class TicketStorage {
  static final List<BookedTicket> _tickets = [];

  static void addTicket(BookedTicket ticket) {
    _tickets.add(ticket);
  }

  static List<BookedTicket> getTickets() {
    return _tickets;
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const MoviesPage(),
      const TicketsPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1A1A2E),
        selectedItemColor: const Color(0xFF00D9FF),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.movie_filter), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Hanya 3 film di Now Showing
    final nowShowingMovies = [
      Movie(
        title: 'Ozora: Penganiayaan Brutal Penguasa Jaksel',
        genre: 'Drama',
        rating: '7.5',
        duration: '118',
        ageRating: '13+',
        imageUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400',
        schedules: [
          MovieSchedule(
            cinema: 'Cinema Premiere',
            price: 85000,
            date: '2025-12-10',
            showtimes: ['13:00', '16:30', '19:45'],
          ),
        ],
      ),
      Movie(
        title: 'Riba',
        genre: 'Drama Religi',
        rating: '7.8',
        duration: '112',
        ageRating: '13+',
        imageUrl: 'https://images.unsplash.com/photo-1594908900066-3f47337549d8?w=400',
        schedules: [
          MovieSchedule(
            cinema: 'Cinema Deluxe',
            price: 70000,
            date: '2025-12-10',
            showtimes: ['17:00', '19:30', '21:45'],
          ),
        ],
      ),
      Movie(
        title: 'Wasiat Warisan',
        genre: 'Drama Keluarga',
        rating: '8.0',
        duration: '110',
        ageRating: '13+',
        imageUrl: 'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=400',
        schedules: [
          MovieSchedule(
            cinema: 'Cinema Regular 1',
            price: 55000,
            date: '2025-12-10',
            showtimes: ['20:00', '14:15', '18:30'],
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.movie, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            const Text('CINEPRABU', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Now Showing',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pilih film favoritmu',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: nowShowingMovies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: nowShowingMovies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final allMovies = [
      Movie(
        title: 'Ozora: Penganiayaan Brutal Penguasa Jaksel',
        genre: 'Drama',
        rating: '7.5',
        duration: '118',
        ageRating: '13+',
        imageUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400',
        schedules: [
          MovieSchedule(
            cinema: 'Cinema Premiere',
            price: 85000,
            date: '2025-12-10',
            showtimes: ['13:00', '16:30', '19:45'],
          ),
        ],
      ),
      Movie(
        title: 'Riba',
        genre: 'Drama Religi',
        rating: '7.8',
        duration: '112',
        ageRating: '13+',
        imageUrl: 'https://images.unsplash.com/photo-1594908900066-3f47337549d8?w=400',
        schedules: [
          MovieSchedule(
            cinema: 'Cinema Deluxe',
            price: 70000,
            date: '2025-12-10',
            showtimes: ['17:00', '19:30', '21:45'],
          ),
        ],
      ),
      Movie(
        title: 'Wasiat Warisan',
        genre: 'Drama Keluarga',
        rating: '8.0',
        duration: '110',
        ageRating: '13+',
        imageUrl: 'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=400',
        schedules: [
          MovieSchedule(
            cinema: 'Cinema Regular 1',
            price: 55000,
            date: '2025-12-10',
            showtimes: ['20:00', '14:15', '18:30'],
          ),
        ],
      ),
      Movie(
        title: 'Nia',
        genre: 'Thriller',
        rating: '7.0',
        duration: '100',
        ageRating: '17+',
        imageUrl: 'https://images.unsplash.com/photo-1518676590629-3dcbd9c5a5c9?w=400',
        schedules: [],
      ),
      Movie(
        title: "Five Nights at Freddy's 2",
        genre: 'Horror Thriller',
        rating: '7.2',
        duration: '118',
        ageRating: '17+',
        imageUrl: 'https://images.unsplash.com/photo-1509347528160-9a9e33742cdb?w=400',
        schedules: [
          MovieSchedule(
            cinema: 'Cinema Deluxe',
            price: 75000,
            date: '2025-12-10',
            showtimes: ['15:30', '18:00', '21:00'],
          ),
        ],
      ),
      Movie(
        title: 'Predator: Badlands',
        genre: 'Action Sci-Fi',
        rating: '7.8',
        duration: '125',
        ageRating: '17+',
        imageUrl: 'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=400',
        schedules: [],
      ),
      Movie(
        title: 'Pangku',
        genre: 'Drama',
        rating: '7.5',
        duration: '103',
        ageRating: '13+',
        imageUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=400',
        schedules: [
          MovieSchedule(
            cinema: 'Cinema Regular 1',
            price: 55000,
            date: '2025-12-10',
            showtimes: ['12:30', '16:00', '19:30'],
          ),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Movies', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Browse Movies',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Semua film yang tersedia',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: allMovies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: allMovies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tickets = TicketStorage.getTickets();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tickets', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: tickets.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.confirmation_number_outlined,
                    size: 100,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Belum ada tiket',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Booking tiket untuk menonton film favoritmu!',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                return TicketCard(ticket: tickets[index]);
              },
            ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final BookedTicket ticket;

  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.confirmation_number, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Booking ID: ${ticket.bookingId}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'CONFIRMED',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.movieTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTicketInfo(Icons.location_on, 'Cinema', ticket.cinema),
                const SizedBox(height: 12),
                _buildTicketInfo(Icons.calendar_today, 'Date', ticket.date),
                const SizedBox(height: 12),
                _buildTicketInfo(Icons.access_time, 'Time', ticket.time),
                const SizedBox(height: 12),
                _buildTicketInfo(Icons.event_seat, 'Seat', ticket.seat),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Payment',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp ${ticket.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.qr_code, size: 100, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Scan QR Code at cinema',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketInfo(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(color: Colors.grey),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.person, size: 50, color: Colors.black),
            ),
            const SizedBox(height: 20),
            const Text(
              'Guest User',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'guest@cineprabu.com',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final hasSchedule = movie.schedules.isNotEmpty;

    return GestureDetector(
      onTap: hasSchedule
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movie: movie),
                ),
              );
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: movie.imageUrl != null
                  ? Image.network(
                      movie.imageUrl!,
                      width: 120,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 120,
                          height: 180,
                          color: Colors.grey[800],
                          child: Icon(
                            Icons.movie,
                            size: 60,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                    )
                  : Container(
                      width: 120,
                      height: 180,
                      color: Colors.grey[800],
                      child: Icon(
                        Icons.movie,
                        size: 60,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.genre,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(movie.rating, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time, color: Colors.grey, size: 18),
                        const SizedBox(width: 4),
                        Text('${movie.duration} min', style: const TextStyle(color: Colors.grey)),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            movie.ageRating,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (hasSchedule)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailPage(movie: movie),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Book Now', style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Coming Soon',
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: movie.imageUrl != null
                  ? Image.network(
                      movie.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[800],
                          child: Icon(
                            Icons.movie_filter,
                            size: 120,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[800],
                      child: Icon(
                        Icons.movie_filter,
                        size: 120,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.genre,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildInfoChip(Icons.star, movie.rating, Colors.amber),
                      const SizedBox(width: 12),
                      _buildInfoChip(Icons.access_time, '${movie.duration} min', Colors.grey),
                      const SizedBox(width: 12),
                      _buildInfoChip(Icons.person, movie.ageRating, Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Select Showtime',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...movie.schedules.map((schedule) {
                    return Column(
                      children: [
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: schedule.showtimes.map((time) {
                            return ShowtimeButton(
                              time: time,
                              price: schedule.price,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeatSelectionPage(
                                      movie: movie,
                                      schedule: schedule,
                                      showtime: time,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class ShowtimeButton extends StatelessWidget {
  final String time;
  final int price;
  final VoidCallback onTap;

  const ShowtimeButton({
    super.key,
    required this.time,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeatSelectionPage extends StatefulWidget {
  final Movie movie;
  final MovieSchedule schedule;
  final String showtime;

  const SeatSelectionPage({
    super.key,
    required this.movie,
    required this.schedule,
    required this.showtime,
  });

  @override
  State<SeatSelectionPage> createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  final List<List<String>> seats = List.generate(
    3,
    (row) => List.generate(10, (col) {
      if ((row == 0 && col == 4) || (row == 1 && col == 5) || (row == 2 && col == 6)) {
        return 'booked';
      }
      return 'available';
    }),
  );

  String? selectedSeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Seat'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Pilih 1 kursi untuk melanjutkan pemesanan',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
            child: Center(
              child: Text(
                'SCREEN',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: List.generate(seats.length, (row) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                            child: Text(
                              String.fromCharCode(65 + row),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ...List.generate(seats[row].length, (col) {
                            final seatId = '${String.fromCharCode(65 + row)}${col + 1}';
                            final status = seats[row][col];
                            final isSelected = selectedSeat == seatId;

                            return GestureDetector(
                              onTap: () {
                                if (status == 'available') {
                                  setState(() {
                                    if (isSelected) {
                                      selectedSeat = null;
                                    } else {
                                      selectedSeat = seatId;
                                    }
                                  });
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: status == 'booked'
                                      ? Colors.grey
                                      : isSelected
                                          ? Theme.of(context).colorScheme.primary
                                          : Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: status == 'booked'
                                        ? Colors.grey
                                        : isSelected
                                            ? Theme.of(context).colorScheme.primary
                                            : Colors.grey.withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: status == 'booked'
                                      ? const Icon(Icons.close, size: 18, color: Colors.white54)
                                      : Text(
                                          '${col + 1}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? Colors.black : Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegend('Available', Theme.of(context).colorScheme.surface, Colors.grey),
                const SizedBox(width: 20),
                _buildLegend('Selected', Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary),
                const SizedBox(width: 20),
                _buildLegend('Booked', Colors.grey, Colors.grey),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedSeat ?? 'No seat selected',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp ${widget.schedule.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: selectedSeat == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingSummaryPage(
                                movie: widget.movie,
                                schedule: widget.schedule,
                                showtime: widget.showtime,
                                seat: selectedSeat!,
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color, Color borderColor) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class BookingSummaryPage extends StatelessWidget {
  final Movie movie;
  final MovieSchedule schedule;
  final String showtime;
  final String seat;

  const BookingSummaryPage({
    super.key,
    required this.movie,
    required this.schedule,
    required this.showtime,
    required this.seat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Summary'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: movie.imageUrl != null
                          ? Image.network(
                              movie.imageUrl!,
                              width: 80,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 80,
                                  height: 120,
                                  color: Colors.grey[800],
                                  child: Icon(
                                    Icons.movie,
                                    size: 40,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                );
                              },
                            )
                          : Container(
                              width: 80,
                              height: 120,
                              color: Colors.grey[800],
                              child: Icon(
                                Icons.movie,
                                size: 40,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.genre,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(showtime, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Booking Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Cinema', schedule.cinema),
              _buildDetailRow('Date', schedule.date),
              _buildDetailRow('Time', showtime),
              _buildDetailRow('Seat', seat),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildPriceRow('Ticket (1x)', 'Rp ${schedule.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
                    const Divider(height: 24),
                    _buildPriceRow(
                      'Total',
                      'Rp ${schedule.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            final bookingId = 'CP${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
            
            TicketStorage.addTicket(
              BookedTicket(
                movieTitle: movie.title,
                cinema: schedule.cinema,
                date: schedule.date,
                time: showtime,
                seat: seat,
                price: schedule.price,
                bookingId: bookingId,
              ),
            );

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: Row(
                  children: [
                    Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 12),
                    const Text('Booking Confirmed!'),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your ticket has been booked successfully.'),
                    const SizedBox(height: 12),
                    Text(
                      'Booking ID: $bookingId',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Check your ticket in the Tickets tab.'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Confirm Booking',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: FontWeight.bold,
            color: isTotal ? const Color(0xFF00D9FF) : null,
          ),
        ),
      ],
    );
  }
}